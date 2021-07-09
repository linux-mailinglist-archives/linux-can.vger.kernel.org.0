Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CA73C2504
	for <lists+linux-can@lfdr.de>; Fri,  9 Jul 2021 15:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhGINe5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 9 Jul 2021 09:34:57 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:34617 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbhGINe5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Jul 2021 09:34:57 -0400
Received: by mail-lf1-f47.google.com with SMTP id f30so23317045lfj.1
        for <linux-can@vger.kernel.org>; Fri, 09 Jul 2021 06:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4phnG/e2Fjt5fW0KCdCwoxcRAjo0y4r4HtYdX5hA3kE=;
        b=GqE7SoHXuHgzO3cRNEGLhOSUScIKkUTasPBTdOmKxjvHRpmq9lyS3NgL5NhuW2YdPn
         F+fY0is9HJc42nMoMe1BRiDD6rbRg72IRbOmWaPnYjpfssKRNnzOs4hJhwIziTChY508
         6AufzCBdh7Klde/uMREoC93IjxZgtnMVEL7HBL99LXQ7PECtyQlgYWtErAx1kKdpN0xd
         xSJdyKMU8dKFB/yNTnJIbFLtvZzpdRVW6GoT9LOxomBFO3crPH12Iv01Kce3/FnVQsuM
         UbeXLx6pgjuuKD23EDLzDsz9nm2fyGyKHAJU043vMPUeXAQOF+5MprCekpFhJCVqDA1B
         ++BA==
X-Gm-Message-State: AOAM531y2qK3HRukbVYBD3r8BIuWARrqqUlLBCSEx7QvMPGn8c3OhVgU
        2lsrZ+iubLc0/Q97UwDGQ+Lo2mejaP+3a/VBJe0=
X-Google-Smtp-Source: ABdhPJzXAKFzunQ4GbxvXBbHa7f43Qhr6FqAhDE3Uyq1qjhYXqQGivees1moKZvBhOKzGQvx+P7eBYAdLSc+dx4wfV0=
X-Received: by 2002:a05:6512:3da6:: with SMTP id k38mr18317512lfv.594.1625837531796;
 Fri, 09 Jul 2021 06:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210628154402.1176099-1-mailhol.vincent@wanadoo.fr>
 <20210628154402.1176099-5-mailhol.vincent@wanadoo.fr> <75fa87a71a3f5fd7d7407a2c514b71690e56eb4e.camel@esd.eu>
In-Reply-To: <75fa87a71a3f5fd7d7407a2c514b71690e56eb4e.camel@esd.eu>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 9 Jul 2021 15:32:00 +0200
Message-ID: <CAMZ6Rq+8hYtaPJEqrNA_hR-KRureu6Gx+sJc79OwLQ8MFe2Pig@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/4] iplink_can: add new CAN FD bittiming
 parameters: Transmitter Delay Compensation (TDC)
To:     =?UTF-8?Q?Stefan_M=C3=A4tje?= <Stefan.Maetje@esd.eu>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Stefan,

On Wed. 7 Jul 2021 at 18:21, Stefan Mätje <Stefan.Maetje@esd.eu> wrote:
> Hi Vincent,
>
> it took some time to get an opinion on the proposed implementation of the user
> interface to control TDC.

Thanks for your involvement, I am always happy to get constructive feedback!

> At first I've inspected the driver implementations for the following CAN cores
> in the Linux tree (FlexCAN, ifi_canfd, MCAN, mcp251xfd) on how the TDC is
> implemented currently. All the drivers for these controllers by default use the
> automatic measurement of TDCV and set up the TDCO value in a way that the SSP
> occurs in the delayed received bit at the same position as the sample point is
> set for the remote receivers (provided the same bitrate setting is used).

ACK. This means that TDCO = SP and that:
  SSP = TDCV + TDCO
      = TDCV + SP

And that’s also the formula I used in can_calc_tdco():
https://elixir.bootlin.com/linux/latest/source/drivers/net/can/dev/bittiming.c#L178

> This is the default mode for TDC, i. e. the TDC is always enabled in FD mode
> (sometimes only for higher data bitrates) and the TDCO is derived from the data
> bitrate settings. This works and the measurement of TDCV compensates for changes
> in delay over time and temperature. This is also the recommended setting of the
> SSP.

Out of curiosity, when you say that this is the "recommended
setting", do you have any references? I agree that this is the
most natural way to calculate TDC but I never found good
references.

> So the opportunity to change the TDC control values is only needed in a test
> enviroment or when trying to tune the behavior to evaluate corner cases.
>
> Need to mention that the TDCV and TDCO values (if implemented) for all mentioned
> controllers are in CAN clock period (Tc) counts and NOT in time quanta (Tq)
> counts!
> The CAN clock period (Tc) also defines the "minimum time quantum" which
> is referenced in the ISO 11898 description of the TDC operation.

Thanks for the clarification. I completely missed the nuances
between the "time quantum" and the "minimum time quantum" and
wrongly assumed that the TDC parameters were also expressed in
time quanta similar to the other bittiming parameters.

Using the time quantum instead of the clock period is my mistake.

> See below for further comments ...
>
> Best regards,
>     Stefan
>
>
> Am Dienstag, den 29.06.2021, 00:44 +0900 schrieb Vincent Mailhol:
> > At high bit rates, the propagation delay from the TX pin to the RX pin
> > of the transceiver causes measurement errors: the sample point on the
> > RX pin might occur on the previous bit.
> >
> > This issue is addressed in ISO 11898-1 section 11.3.3 "Transmitter
> > delay compensation" (TDC).
> >
> > This patch brings command line support to nine TDC parameters which
> > were recently added to the kernel's CAN netlink interface in order to
> > implement TDC:
> >   - IFLA_CAN_TDC_TDCV_MIN: Transmitter Delay Compensation Value
> >     minimum value
> >   - IFLA_CAN_TDC_TDCV_MAX: Transmitter Delay Compensation Value
> >     maximum value
> >   - IFLA_CAN_TDC_TDCO_MIN: Transmitter Delay Compensation Offset
> >     minimum value
> >   - IFLA_CAN_TDC_TDCO_MAX: Transmitter Delay Compensation Offset
> >     maximum value
> >   - IFLA_CAN_TDC_TDCF_MIN: Transmitter Delay Compensation Filter
> >     window minimum value
> >   - IFLA_CAN_TDC_TDCF_MAX: Transmitter Delay Compensation Filter
> >     window maximum value
> >   - IFLA_CAN_TDC_TDCV: Transmitter Delay Compensation Value
> >   - IFLA_CAN_TDC_TDCO: Transmitter Delay Compensation Offset
> >   - IFLA_CAN_TDC_TDCF: Transmitter Delay Compensation Filter window
> >
> > TDCV is reported only if the device supports
> > CAN_CTRLMODE_TDC_MANUAL.
>
> I think the TDCV value should be reported in any case. Assume the interface is
> in default mode (as described before and selected by omitting the tdc-mode
> parameter) or in your auto mode then the TDCV value reported should be the
> measured value of the TDCV if available. This could then serve as a useful
> starting point for manual configuration experiments. If the measured TDCV is not
> available from the controller registers it should return zero.

Your comment is valid. The reason I did not implement it is
because I do not own a device capable of reporting the value.

I can propose to add a virtual function in struct can_priv:
+

 int (*do_get_auto_tdcv)(struct net_device *dev);

If the function is implemented, use it to report TDCV when in auto mode.

I disagree on one point: if the value is not available, I think
it is better not report TDCV rather than reporting zero. As I
commented in my other patches, zero is a valid value for TDCV, we
can not use it to mean "not available" or "not set".

> A similar idea holds true for the TDCO value. When the driver calulates a
> suitable value for the TDCO (in default mode) the "ip -details link show" should
> report the TDCO value set by the driver.

That should be the current behavior. In either auto or manual
modes, the TDCO value inputted by the user should be returned. In
default (i.e. no parameters calculated), the TDCO value is
reported only if TDC is on (c.f. can_calculate_tdco() function).
Did you witnessed TDCO not being reported after TDC being set?

> > TDCF is reported only if tdcf_max is not
> > zero.
>
> Note: I think TDCF is only supported by MCAN so far.

FYI, the SAM E70/S70/V70/V71 Family from Microchip also support TDCF:
https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/etas_es58x/es58x_fd.c#L511

> > All those new parameters are nested together into the attribute
> > IFLA_CAN_TDC.
> >
> > A tdc-mode parameter allow to specify how to opperate. Valid options
> > are:
> >
> >   * auto: the transmitter automatically measures TDCV. As such, TDCV
> >     values can not be manually provided. In this mode, the user must
> >     specify TDCO and may also specify TDCF if supported.
> >
> >   * manual: Use the TDCV value provided by the user are used. In this
> >     mode, the user must specify both TDCF and TDCO and may also
> >     specify TDCF if supported.
> >
> >   * off: TDC is explicitely disabled.
> >
> >   * tdc-mode parameter omitted: the kernel decides whether TDC should
> >     be enabled or not and if so, it calculates the TDC values.
>
> This mode with tdc-mode parameter omitted I have called "default mode" in my
> introduction.

ACK. This is also my intent to use it as default mode.
I will add a comment to the patch description to reflect this.

> For reference, here are a few samples of how the output looks like:
> >
> > $ ip link set can0 type can bitrate 1000000 dbitrate 8000000 fd on tdco 7 tdcf
> > 8 tdc-mode auto
>
> So switching from a setting with "tdc-mode auto" (like before) back to the
> default mode should then be done by
>
> $ ip link set can0 type can bitrate 1000000 dbitrate 8000000 fd on

Yes

> But as far as I understand without any TDC parameters the ip tool does not send
> the IFLA_CAN_TDC structure to the kernel. So on the kernel level this is the
> signal to switch back to "default mode" for TDC?

The signal is on the CAN_CTRLMODE_TDC_{AUTO,MANUAL} flags:
  * If the flags are omitted (not set): default mode (parameter omitted)
  * If both are set to false: TDC off
  * If CAN_CTRLMODE_TDC_AUTO is set to true: TDC auto mode
  * If CAN_CTRLMODE_TDC_MANUAL is set to true: TDC manual mode

N.B.: The kernel forbids both CAN_CTRLMODE_TDC_{AUTO,MANUAL} to be
both set to true at the same time.

> >
> > $ ip --details link show can0
> > 1:  can0: <NOARP,ECHO> mtu 72 qdisc noop state DOWN mode DEFAULT group default
> > qlen 10
> >     link/can  promiscuity 0 minmtu 0 maxmtu 0
> >     can <FD,TDC_AUTO> state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
> >         bitrate 1000000 sample-point 0.750
> >         tq 12 prop-seg 29 phase-seg1 30phase-seg2 20  sjw 1 brp 1
> >         ES582.1/ES584.1: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512
> > brp_inc 1
> >         dbitrate 8000000 dsample-point 0.700
> >         dtq 12 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1 dbrp 1
> >         tdco 7 tdcf 8
> >         ES582.1/ES584.1: dtseg1 2..32 dtseg2 1..16 dsjw 1..8 dbrp 1..32
> > brp_inc 1
> >         tdco 0..127 tdcf 0..127
> >         clock 80000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536
> > gso_max_segs 65535
>
> After looking at this I have a concern on the design decision to make the
> transferred TDCV/TDCO/TDCF values defined as multiple of time quanta (Tq).
>
> As I mentioned before the all controllers use register values based on multiples
> of CAN clock periods (Tc). And in the IFLA_CAN_TDC_TDCx_{MIN|MAX} or "struct
> can_tdc_const" tables shown as

That’s not a design decision but a mistake. I will correct and resend
a new patch.

> >         tdco 0..127 tdcf 0..127
>
> you use the maximum allowed values for the controller registers which are also
> the Tc based values.
>
> But in include/linux/can/bittiming.h the TDCx values are described as being
> multiples of time quanta (Tq).
>
> But this creates a problem with data bitrates where dbrp is 2. If this is the
> case at the end the driver needs to convert the TDCx values from Tq based
> numbers to Tc based numbers. Then you may have the case where "tdco 64" is set
> on the "ip" command line. The can_tdc_changelink() function happily compares the
> given "tdco" with the limits and lets this value pass. But some code needs to
> multiply with dbrp=2 which would then overflow the register bits.
>
> On the other hand even if can_tdc_changelink() does the conversion and the check
> already it would signal -EINVAL for a value (64) that is apparently announced as
> legal judging from the output of "ip -d link show ...".
>
> To eliminate this discrepancy "ip -d link show ..." would need to display only
> "tdco 0..63" as allowed values if dbrp==2. So the kernel possibly needs to
> convert the allowed TDCx min / max constants from Tc based values to Tq based
> values. I think this would be a nightmare when the allowed limits change based
> on the bitrate setting.
>
> So I would propose to change the documentation in include/linux/can/bittiming.h
> to say that the TDCx values are based on the CAN clock period (Tc). Then the
> code for can_tdc_changelink() checks for the correct limits. And also the help
> output of "ip link help can" should explicitely state that the TDCx values are
> NOT based on time quanta.
>
> I think the confusion of the user is less with that approach because it is not
> so far away from the documented register interface of the CAN controllers. Even
> if it would be the only point in the CAN area where settings are not based on
> time quanta (Tq) but on CAN clock periods (Tc).

ACK.

> And as I mentioned above the "normal" user should never need to set TDC values
> and always use the "default" mode. The expert user should perhaps be able to
> understand the different time bases for TDCx values and other timing parameters.

ACK. This is also my intent.

> And in a testing and evaluation environment the higher resolution of the Tc
> based TDCx values may also be a benefit. I. e. when reading the measured TDCV
> value to monitor the change of the delay over time and temperature.

From your comments, I see two immediate actions:
  * Change the unit from time quanta to clock period (Tc)
  * Add a method to retrieve TDCV value when in auto mode

Right now, I am in holiday, with no access to my usual testing
gears.  I will prepare a version of the patches but you might
have to wait until August.


Yours sincerely,
Vincent
