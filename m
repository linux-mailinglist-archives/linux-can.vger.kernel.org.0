Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696F940AB00
	for <lists+linux-can@lfdr.de>; Tue, 14 Sep 2021 11:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhINJhF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 14 Sep 2021 05:37:05 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:44997 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhINJhB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Sep 2021 05:37:01 -0400
Received: by mail-lf1-f54.google.com with SMTP id p29so537725lfa.11
        for <linux-can@vger.kernel.org>; Tue, 14 Sep 2021 02:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Idw001S1xp7a5JP7/Tl2CMkaRRP23vBRqDmYi3sMIFE=;
        b=ofVahz9Tnt7y7hlciIGc1wnQ39IlY3Pj1GMjy/T6MrkV5dnEQGsPBy8n3pncr1rV2d
         0+hJ/3Dmg/yd4Yw/T0F7u78S6ht0ldIH/dsBP8CDcXv5iCqoEaqORSCiMRpahGZzazV3
         wI5sM4xx1vp8al2xskMiD9aoNlzKtPyq9kdcbXkN2HTBwMW1mdYOSs+5tqeIo0wzGlcN
         rSdY6OQwHHNN8ovtH6WK6n28ktVK+bf4AyS+2Jo/7si8VeU4sRN2JtfxoTKlwUGt9Lvt
         nlBoVJimjmNw8bCWMR2ewddMGzU5sLP/i+euALGA8UnEIiQMmYtlH3Y2RMryWchnlVRf
         twvg==
X-Gm-Message-State: AOAM533ci5gUySdVB7y9qdFse1TztlCssVJ2sddSp4wB+tlnFbJZh4pr
        07S8nXh3cafO9Qpk4PAFaE/1j8AyGAwzCiC02I4=
X-Google-Smtp-Source: ABdhPJwhYIVpv/u1ErJWfeRvR3jFJlxEEubBFjb5Fm0yFESVBdeDZLMX4zSKretVINFJIijK1l7ekWvPkgMYXhHklRY=
X-Received: by 2002:a05:6512:1292:: with SMTP id u18mr2893241lfs.384.1631612143287;
 Tue, 14 Sep 2021 02:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210906160310.54831-1-mailhol.vincent@wanadoo.fr>
 <20210906160310.54831-2-mailhol.vincent@wanadoo.fr> <CAMZ6RqJaY_jRv+AZ6oH6rxP=dE9Vs1fBwhBQJq_o3dgMWM1vUg@mail.gmail.com>
 <bccb03f4-5179-895a-f803-5adf543a8c19@hartkopp.net>
In-Reply-To: <bccb03f4-5179-895a-f803-5adf543a8c19@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 14 Sep 2021 18:35:31 +0900
Message-ID: <CAMZ6RqKpiYOLn7=NoN1U4PwnW4fdrJ1N57nGrCJ6FgKnyx5GvQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] can: netlink: prevent incoherent can configuration
 in case of early return
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

On Wed. 8 sep. 2021 at 20:41, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> - nextdev ML
> - linux-kernel ML
>
> Hi Vincent,
>
> On 07.09.21 14:51, Vincent MAILHOL wrote:
> > On Tue. 7 Sep. 2021 at 01:03, Vincent Mailhol
> > <mailhol.vincent@wanadoo.fr> wrote:
> >> struct can_priv has a set of flags (can_priv::ctrlmode) which are
> >> correlated with the other fields of the structure. In
> >> can_changelink(), those flags are set first and copied to can_priv. If
> >> the function has to return early, for example due to an out of range
> >> value provided by the user, then the global configuration might become
> >> incoherent.
> >>
> >> Example: the user provides an out of range dbitrate (e.g. 20
> >> Mbps). The command fails (-EINVAL), however the FD flag was already
> >> set resulting in a configuration where FD is on but the databittiming
> >> parameters are empty.
>
> When the ip configuration fails you get an error code. And you
> *typically* do it again to fix your wrong command line parameters.
>
> ¯\_(ツ)_/¯

Overall yes. I tried to think of a counterexample and the best I
could think of is if the user does:
# ip link set can0 type can bitrate 500000 dbitrate 20000000 fd on; ip
link set can0 up

In which case, the .ndo_open() function of the driver would be
triggered with incorrect parameters.

> If not the attempt to set the CAN interface to 'up' will fail (as the
> last line of defense).

Mostly correct: open_candev() will spot that the data bitrate is not set
making the .ndo_open() fails as long as the driver correctly
checks open_candev() return value.

However, one driver fails to check the return value of open_candev():
https://elixir.bootlin.com/linux/v5.11/source/drivers/net/can/softing/softing_fw.c#L636

So, for this particular driver, we can send incoherent values to the device.

> The code with all the sanity checks is already pretty complex IMO.

ACK.

> I wonder if this effort is worth it.

Well, I was thinking "this is a bug so let's fix it". But your
argument is fair. I also did not like how complex the code was
getting when trying to fix that. I guess that this bug is
acceptable. I will leave it as it is.

Now, I am just worried about the softing driver.

Thanks.


Yours sincerely,
Vincent
