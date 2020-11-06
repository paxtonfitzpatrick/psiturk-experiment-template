const psiturk = new PsiTurk(uniqueId, adServerLoc, mode);

const N_TRIALS = 4,
  STIM_DURATION = 1500,
  RESPONSE_LETTER = 'f';
const RESPONSE_KEYCODE = jsPsych.pluginAPI.convertKeyCharacterToKeyCode(RESPONSE_LETTER);

const welcome = {
    type: "html-keyboard-response",
    stimulus: "Welcome to the experiment! Press any key to begin."
};

const go_nogo_instructions = {
    type: "html-keyboard-response",
    stimulus: "<p>In this experiment, a circle will appear in the center "
      + "of the screen.</p><p>If the circle is <span style='color:blue'>blue</span>, "
      + "press the letter <strong>F</strong> on the keyboard as fast as you can.</p>"
      + "<p>If the circle is <span style='color:orange'>orange</span>, <strong>do not press "
      + "any key</strong>.</p><div style='width: 700px;'><div style='float: left;'>"
      + "<img src='/static/images/blue.png'><p class='small'><strong>Press the F key</strong>"
      + "</p></div><div class='float: right;'><img src='/static/images/orange.png'>"
      + "<p class='small'><strong>Do not press a key</strong></p></div></div>"
      + "<p>Press any key to begin.</p>",
    post_trial_gap: 2000
};

const stimuli = [
  {image: "/static/images/blue.png", data: {correct_response: RESPONSE_KEYCODE}},
  {image: "/static/images/orange.png", data: {correct_response: null}}
];

const single_trial = {
    type: "image-keyboard-response",
    stimulus: jsPsych.timelineVariable('image'),
    choices: [RESPONSE_LETTER],
    stimulus_duration: STIM_DURATION,
    response_ends_trial: false,
    trial_duration: function() {
        return Math.floor(Math.random() * STIM_DURATION * 1.5) + STIM_DURATION
    },
    data: jsPsych.timelineVariable('data'),
    on_finish: function(data) {
        data.correct = data.key_press === data.correct_response
    }
};

const all_trials = {
    timeline: [single_trial],
    timeline_variables: stimuli,
    repetitions: N_TRIALS,
    randomize_order: true
};

const debrief = {
    type: "html-button-response",
    choices: ["<strong>Finish</strong>"],
    stimulus: "<p><strong>Thank you for participating!</strong>"
      + "<p>Press the <strong>Finish</strong> button to complete the experiment.</p>"
};

const experiment_timeline = [welcome, go_nogo_instructions, all_trials, debrief];


jsPsych.init({
    timeline: experiment_timeline,
    on_finish: function() {
        psiturk.saveData({
            success: function() { psiturk.completeHIT(); }
        });
    },
    on_data_update: function(data) {
        psiturk.recordTrialData(data);
    }
});