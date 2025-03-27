function vcsendmail(strsubject,strmessage)
    if nargin<1 || isempty(strsubject)
        strsubject = 'Matlab job completed';
    end
    if nargin<2 || isempty(strmessage)
        strmessage = 'The Matlab job has completed';
    end
    setpref('Internet','E_mail','vasco.curdia@sf.frb.org');   
    setpref('Internet','SMTP_Server','10.121.41.24');
    props = java.lang.System.getProperties;
    props.setProperty('mail.smtp.port', '25');
    props.setProperty('mail.smtp.starttls.enable', 'false');
    props.setProperty('mail.smtp.ssl.trust', '*');
    props.setProperty('mail.smtp.auth','false');
    sendmail('vasco.curdia@sf.frb.org', strsubject, strmessage);
end
