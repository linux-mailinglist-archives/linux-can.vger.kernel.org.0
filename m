Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAE5133059
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2020 21:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgAGUJr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Jan 2020 15:09:47 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45011 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGUJr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Jan 2020 15:09:47 -0500
Received: by mail-lj1-f195.google.com with SMTP id u71so837421lje.11
        for <linux-can@vger.kernel.org>; Tue, 07 Jan 2020 12:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mGvpsYZRfzmSW6VEI7Bbv6XX35SEGTyEBRh+5Oj7BvM=;
        b=iCeT4ZGgO9IzW7n5rdaK+vDEUUtRahqyQ0eZiwuUmtUqLv+1A6I8O8wUmv3mksT+tc
         cLGDX7CdNMHydLNWF1JL/3LoZQpPNDMGIlqP9Y6G5pkdkkadPwyCcmbY6/SDS4UQzKCU
         AwGJw7t5djWgbJ21HUS0rDs5j65fRML5qxJZkUcBx1MmWfvMRR1b94PefS3MZT68I/8n
         vfXoAsCQ0Ww5DzR4zXoXT4YWGWH9OGlDAsoyYxzvmVaHI0vp+zTadL/g8HhbZY7ZNF63
         OG9t5fsZepEUm/0U2PrNtIq/Ra9JIuJ+R52+FRcj1UPl30zf3OSYs6tkx3vQPTzS0DoZ
         DTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mGvpsYZRfzmSW6VEI7Bbv6XX35SEGTyEBRh+5Oj7BvM=;
        b=NQVLM/+9K6yfeXOU9hhy2O+zmWWFDDIQKQUsIM10VPRFb5bRzyee6MxjoreYE5zjtb
         +JCj5Ep2b6OC40qarOw5JxFRg8Np+d3uDHHvLufc7WX++Qijrvc3C3pxgdEbHMq5Arx4
         UgobRPJQin7iiM76dS7H266BMecZunppCRa76bI2v80msfTxreJXB+Bgpazzn4kGoIie
         jVbQiCOXGYPPNLElybU/LNf7cXflVy2Pp84PK96DqaNKfJdXN+EPbUMf8vjkqv6X1j4e
         YF92EbuyNMj/r2dWMOqzRdem3Om4Qe/UPbH8j1C1eVhSrBjbCqb1IZyVju4dT1dRaMUc
         rIHg==
X-Gm-Message-State: APjAAAV+qo6r9i3tEQV9X2OWBHUPLfzKTMpcqoA7ClBpIAjTYGtY39/e
        Cgsn0i91ncG71enQpR6il011pB+fZF/kWc66r/A=
X-Google-Smtp-Source: APXvYqzrfS8JDlKFV7c8U1JDKYOAJ5lA6gvM55K5BL3+od4XtwOecI1eCzXkQ/yCgakSc9NG7IU3IX7i49oVW+FoY9Y=
X-Received: by 2002:a2e:93d5:: with SMTP id p21mr752077ljh.50.1578427785320;
 Tue, 07 Jan 2020 12:09:45 -0800 (PST)
MIME-Version: 1.0
References: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
 <1576596206-27260-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <CAHChkrviSWcA0KS6jrzfPgE0ygs3tup1GseOeLto6OvLOgH2iw@mail.gmail.com> <20200107190655.GA17976@x1.vandijck-laurijssen.be>
In-Reply-To: <20200107190655.GA17976@x1.vandijck-laurijssen.be>
From:   Elenita Hinds <ecathinds@gmail.com>
Date:   Tue, 7 Jan 2020 14:09:33 -0600
Message-ID: <CAHChkru-9uYo1wrdf8PQUv3AQcsQCag7PR7TCsR3g2xEoHjbzA@mail.gmail.com>
Subject: Re: [RFC v3] c_can: improve latency and avoid packet loss
To:     Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Yeah, I also think the current split (8TX) is good and will probably
work for most applications.

Thanks,
Elenita

On Tue, Jan 7, 2020 at 1:06 PM Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
>
> On di, 07 jan 2020 10:58:26 -0600, Elenita Hinds wrote:
> > Hi,
> > I've been testing version 4 of this patch series on our product and it
> > looks good so far (only 1 packet loss at the beginning of each tests
> > after hours of run, which is insignificant). On my end, the 64 message
> > objects plus setting the TI chip's CPU frequency scaling/governor to
> > 'performance' (from ondemand which apparently had issues)  made a huge
> > difference.
>
> Thanks for sharing your results. It confirms that it really improved.
> >
> > I'm assuming there is no other way to make the RX/TX split configurable?
>
> I understood from Marc on 17 Dec that one would want to avoid large HW
> queues.
> Making it configurable from Kconfig seems not appropriate.
> From device-tree seems possible.
> I considered that 8 TX queue is good enough, and assign the
> remaining HW space to recv.
>
> I honestly see no reason anymore to make it adustable, other than
> that I choose a bad fixed value.
> How would you want to make the tx/rx split?
>
> Kind regards,
> Kurt
