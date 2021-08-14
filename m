Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587C93EC1C5
	for <lists+linux-can@lfdr.de>; Sat, 14 Aug 2021 11:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbhHNJvw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Sat, 14 Aug 2021 05:51:52 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:41498 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhHNJvv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 14 Aug 2021 05:51:51 -0400
Received: by mail-lf1-f47.google.com with SMTP id y34so24729326lfa.8
        for <linux-can@vger.kernel.org>; Sat, 14 Aug 2021 02:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lk45oWpKodvV+b6jk6aplkpGPnilZ56yS4ZIfw10IqY=;
        b=IoWz7g2iHQiXpNB9It/AzDAQmvYmMDixe5CYvN5y2tlIqkujYEZbK4446gVIpa0008
         p97TFlwXNYeObHuh+f4k1xIhSxJ1q8z/ghEeaMK3s1SKwQIR89LCIVvAkjeUhgN4xl+M
         UgXVS4wKFkHdcWUKD3LWh2RJyz3VWs08aTbHJABZRHUgUJ3ENoVnjMNthdL+jJ6SQZWn
         i9eDVRL03YbNZgGD0tZ3kaWVn6P18HcRGBY44rP3fghDfWRojgbv6V1+PVpelab46nBm
         F8PQPkFLGIqsjOlqj0spMNVojcgteCv8Tu9IXX4Q+n5eX8wwLcLFeLp6WgLfnseeNsOI
         HB0w==
X-Gm-Message-State: AOAM530UJOV6RFVcxnJYFCWubuk0TBhtJhgRZgaCLckZNRqMWnWcOfSl
        ukTVFslL6C+qKTHEVAJCnVO9f51PdWyEyRf2E1g=
X-Google-Smtp-Source: ABdhPJzWAa24PpI12zdCowtU8PsDulJHNnDv7prF+PN8rfrIyzgz7UnDuQBXqpQAP3VszrUASNq2AqJotxW7nACWmTo=
X-Received: by 2002:ac2:5d27:: with SMTP id i7mr4641090lfb.488.1628934682624;
 Sat, 14 Aug 2021 02:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210628154402.1176099-1-mailhol.vincent@wanadoo.fr>
 <20210628154402.1176099-5-mailhol.vincent@wanadoo.fr> <75fa87a71a3f5fd7d7407a2c514b71690e56eb4e.camel@esd.eu>
 <CAMZ6Rq+8hYtaPJEqrNA_hR-KRureu6Gx+sJc79OwLQ8MFe2Pig@mail.gmail.com> <d9dfe2f1df48f0f4a7ee413f9263f741ca1014f8.camel@esd.eu>
In-Reply-To: <d9dfe2f1df48f0f4a7ee413f9263f741ca1014f8.camel@esd.eu>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 14 Aug 2021 18:51:11 +0900
Message-ID: <CAMZ6RqJ4tc2o7RVY40tUZjxr6sw8wToA80aYiD9RjwZYSh3Qmw@mail.gmail.com>
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

On Mon. 9 Aug. 2021 at 23:44, Stefan Mätje <Stefan.Maetje@esd.eu> wrote:
> Some late comments on this ...

Your comments arrived just at the good timing, when I was
starting to work on the new version of the patch series.

> Am Freitag, den 09.07.2021, 15:32 +0200 schrieb Vincent MAILHOL:
> > Hi Stefan,
> >
> > On Wed. 7 Jul 2021 at 18:21, Stefan Mätje <Stefan.Maetje@esd.eu> wrote:
> > > Hi Vincent,
> > >
> > > it took some time to get an opinion on the proposed implementation of the user
> > > interface to control TDC.
> >
> > Thanks for your involvement, I am always happy to get constructive feedback!
> >
> > > At first I've inspected the driver implementations for the following CAN cores
> > > in the Linux tree (FlexCAN, ifi_canfd, MCAN, mcp251xfd) on how the TDC is
> > > implemented currently. All the drivers for these controllers by default use the
> > > automatic measurement of TDCV and set up the TDCO value in a way that the SSP
> > > occurs in the delayed received bit at the same position as the sample point is
> > > set for the remote receivers (provided the same bitrate setting is used).
> >
> > ACK. This means that TDCO = SP and that:
> >   SSP = TDCV + TDCO
> >       = TDCV + SP
> >
> > And that’s also the formula I used in can_calc_tdco():
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/can/dev/bittiming.c#L178
>
> A nitpick on the can_calc_tdco() function. There you calculate the sample_point_in_tq
> like this:
>
>         u32 sample_point_in_tq = can_bit_time(dbt) * dbt->sample_point / 1000;
>
> You use there dbt->sample_point which is a calculated value and the whole formula may
> undergo rounding and truncation (even already the input value dbt->sample_point has).
> A formula where you even don't need to think about this issue would be:
>
>         u32 sample_point_in_tq = can_bit_time(dbt) - dbt->phase_seg2;

Thanks for this remark. Regardless, I had to rewrite the formula
to change from time quantum to clock period. At the end, I opted
for below formula:

u32 sample_point_in_tc = (CAN_SYNC_SEG + dbt->prop_seg +
                          dbt->phase_seg1) * dbt->brp;

> >
> > > This is the default mode for TDC, i. e. the TDC is always enabled in FD mode
> > > (sometimes only for higher data bitrates) and the TDCO is derived from the data
> > > bitrate settings. This works and the measurement of TDCV compensates for changes
> > > in delay over time and temperature. This is also the recommended setting of the
> > > SSP.
> >
> > Out of curiosity, when you say that this is the "recommended
> > setting", do you have any references? I agree that this is the
> > most natural way to calculate TDC but I never found good
> > references.
>
> The basic idea behind the setting of the TDCO is that all nodes on the bus (the
> transmitter and the receiving nodes) should sample their received bits at the same
> offset during the bit-time. Because the TDCV value compensates the tranmitter round
> trip delay (TX -> RX pin) the TDCO value should be the number of CAN clock cycles
> to reach the Sample Point Offset (SP) in the bit time which is
>
> TDCO = (1 SYNC_Tq + PROP_Segment_Tqs + TSEG1_Tqs) * DBRP
>
> I found a recommendation for this in the FlexCAN controller's description in the
> reference manual for a NXP embedded controller family:
>
> S32K1xx Series Reference Manual, Document Number: S32K1XXRM, Rev. 13, 04/2020
>
> On page 1921, section "55.5.9.3 Transceiver delay compensation" you can find this
> recommendated formula:
>
>         Offset = (FPSEG1 + FPROPSEG + 2) x (FPRESDIV + 1)
>
> which boils down to the formula for TDCO shown before if you replace the register
> contents of the formula for "Offset" by the "real" values shown in the formula
> for TDCO.
>
> Written differently with "real" values in {} (compare the cited reference manual
> on page 1874 about the register contents):
>
>         Offset = ({FPSEG1 +1} + {FPROPSEG} + {SYNC_Tq}) * ({FPRESDIV + 1})
>         Offset = (TSEG1_Tqs + Prop_Segment_Tqs + SYNC_Tq) * (DBRP)

Thanks for the reference.

> > > So the opportunity to change the TDC control values is only needed in a test
> > > enviroment or when trying to tune the behavior to evaluate corner cases.
> > >
> > > Need to mention that the TDCV and TDCO values (if implemented) for all mentioned
> > > controllers are in CAN clock period (Tc) counts and NOT in time quanta (Tq)
> > > counts!
> > > The CAN clock period (Tc) also defines the "minimum time quantum" which
> > > is referenced in the ISO 11898 description of the TDC operation.
> >
> > Thanks for the clarification. I completely missed the nuances
> > between the "time quantum" and the "minimum time quantum" and
> > wrongly assumed that the TDC parameters were also expressed in
> > time quanta similar to the other bittiming parameters.
> >
> > Using the time quantum instead of the clock period is my mistake.
> >
> > > See below for further comments ...
> > >
> > > Best regards,
> > >     Stefan
> > >
> > >
> > > Am Dienstag, den 29.06.2021, 00:44 +0900 schrieb Vincent Mailhol:
> > > > At high bit rates, the propagation delay from the TX pin to the RX pin
> > > > of the transceiver causes measurement errors: the sample point on the
> > > > RX pin might occur on the previous bit.
> > > >
> > > > This issue is addressed in ISO 11898-1 section 11.3.3 "Transmitter
> > > > delay compensation" (TDC).
> > > >
> > > > This patch brings command line support to nine TDC parameters which
> > > > were recently added to the kernel's CAN netlink interface in order to
> > > > implement TDC:
> > > >   - IFLA_CAN_TDC_TDCV_MIN: Transmitter Delay Compensation Value
> > > >     minimum value
> > > >   - IFLA_CAN_TDC_TDCV_MAX: Transmitter Delay Compensation Value
> > > >     maximum value
> > > >   - IFLA_CAN_TDC_TDCO_MIN: Transmitter Delay Compensation Offset
> > > >     minimum value
> > > >   - IFLA_CAN_TDC_TDCO_MAX: Transmitter Delay Compensation Offset
> > > >     maximum value
> > > >   - IFLA_CAN_TDC_TDCF_MIN: Transmitter Delay Compensation Filter
> > > >     window minimum value
> > > >   - IFLA_CAN_TDC_TDCF_MAX: Transmitter Delay Compensation Filter
> > > >     window maximum value
> > > >   - IFLA_CAN_TDC_TDCV: Transmitter Delay Compensation Value
> > > >   - IFLA_CAN_TDC_TDCO: Transmitter Delay Compensation Offset
> > > >   - IFLA_CAN_TDC_TDCF: Transmitter Delay Compensation Filter window
> > > >
> > > > TDCV is reported only if the device supports
> > > > CAN_CTRLMODE_TDC_MANUAL.
> > >
> > > I think the TDCV value should be reported in any case. Assume the interface is
> > > in default mode (as described before and selected by omitting the tdc-mode
> > > parameter) or in your auto mode then the TDCV value reported should be the
> > > measured value of the TDCV if available. This could then serve as a useful
> > > starting point for manual configuration experiments. If the measured TDCV is not
> > > available from the controller registers it should return zero.
> >
> > Your comment is valid. The reason I did not implement it is
> > because I do not own a device capable of reporting the value.
> >
> > I can propose to add a virtual function in struct can_priv:
> > +
> >
> >  int (*do_get_auto_tdcv)(struct net_device *dev);
> >
> > If the function is implemented, use it to report TDCV when in auto mode.
>
> I also think that this function is needed because when the netlink interface
> call runs through the kernel there must be driver / controller specific code
> to extract the current TDCV value from the CAN controller.
>
>
> > I disagree on one point: if the value is not available, I think
> > it is better not report TDCV rather than reporting zero. As I
> > commented in my other patches, zero is a valid value for TDCV, we
> > can not use it to mean "not available" or "not set".
>
> This is fine with me. But aren't the TDCx values put in a single structure
> (NFLA_NESTED...?). And how can the user level detect that the TDCV value
> is provided or not?
>
> Ok, on a second look it seems that there is the choice to add the IFLA_CAN_TDC_TDCV
> "structure" in can_fill_info() or not ...

Yes. And for more details, you can have a look at
can_print_tdc_opt() function in my patch. This behavior is
already implemented:

|        if (tb[IFLA_CAN_TDC_TDCV]) {
|            __u32 *tdcv = RTA_DATA(tb[IFLA_CAN_TDC_TDCV]);
|
|            print_uint(PRINT_ANY, "tdcv", " tdcv %u", *tdcv);
|        }

> > > A similar idea holds true for the TDCO value. When the driver calulates a
> > > suitable value for the TDCO (in default mode) the "ip -details link show" should
> > > report the TDCO value set by the driver.
> >
> > That should be the current behavior. In either auto or manual
> > modes, the TDCO value inputted by the user should be returned. In
> > default (i.e. no parameters calculated), the TDCO value is
> > reported only if TDC is on (c.f. can_calculate_tdco() function).
> > Did you witnessed TDCO not being reported after TDC being set?
> >
> > > > TDCF is reported only if tdcf_max is not
> > > > zero.
> > >
> > > Note: I think TDCF is only supported by MCAN so far.
> >
> > FYI, the SAM E70/S70/V70/V71 Family from Microchip also support TDCF:
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/etas_es58x/es58x_fd.c#L511
>
> I would like to mention that the controller implemented in the SAM E70* controller
> family is a MCAN implementation / IP core. So I think we're both right ;-)

I never realized that. Thanks for pointing this out.

> > > > All those new parameters are nested together into the attribute
> > > > IFLA_CAN_TDC.
> > > >
> > > > A tdc-mode parameter allow to specify how to opperate. Valid options
> > > > are:
> > > >
> > > >   * auto: the transmitter automatically measures TDCV. As such, TDCV
> > > >     values can not be manually provided. In this mode, the user must
> > > >     specify TDCO and may also specify TDCF if supported.
> > > >
> > > >   * manual: Use the TDCV value provided by the user are used. In this
> > > >     mode, the user must specify both TDCF and TDCO and may also
> > > >     specify TDCF if supported.
> > > >
> > > >   * off: TDC is explicitely disabled.
> > > >
> > > >   * tdc-mode parameter omitted: the kernel decides whether TDC should
> > > >     be enabled or not and if so, it calculates the TDC values.
> > >
> > > This mode with tdc-mode parameter omitted I have called "default mode" in my
> > > introduction.
> >
> > ACK. This is also my intent to use it as default mode.
> > I will add a comment to the patch description to reflect this.
> >
> > > For reference, here are a few samples of how the output looks like:
> > > >
> > > > $ ip link set can0 type can bitrate 1000000 dbitrate 8000000 fd on tdco 7 tdcf
> > > > 8 tdc-mode auto
> > >
> > > So switching from a setting with "tdc-mode auto" (like before) back to the
> > > default mode should then be done by
> > >
> > > $ ip link set can0 type can bitrate 1000000 dbitrate 8000000 fd on
> >
> > Yes
> >
> > > But as far as I understand without any TDC parameters the ip tool does not send
> > > the IFLA_CAN_TDC structure to the kernel. So on the kernel level this is the
> > > signal to switch back to "default mode" for TDC?
> >
> > The signal is on the CAN_CTRLMODE_TDC_{AUTO,MANUAL} flags:
> >   * If the flags are omitted (not set): default mode (parameter omitted)
> >   * If both are set to false: TDC off
> >   * If CAN_CTRLMODE_TDC_AUTO is set to true: TDC auto mode
> >   * If CAN_CTRLMODE_TDC_MANUAL is set to true: TDC manual mode
> >
> > N.B.: The kernel forbids both CAN_CTRLMODE_TDC_{AUTO,MANUAL} to be
> > both set to true at the same time.
> :
> Lots of stuff cut away
> :
> > > So I would propose to change the documentation in include/linux/can/bittiming.h
> > > to say that the TDCx values are based on the CAN clock period (Tc). Then the
> > > code for can_tdc_changelink() checks for the correct limits. And also the help
> > > output of "ip link help can" should explicitely state that the TDCx values are
> > > NOT based on time quanta.
> > >
> > > I think the confusion of the user is less with that approach because it is not
> > > so far away from the documented register interface of the CAN controllers. Even
> > > if it would be the only point in the CAN area where settings are not based on
> > > time quanta (Tq) but on CAN clock periods (Tc).
> >
> > ACK.
> >
> > > And as I mentioned above the "normal" user should never need to set TDC values
> > > and always use the "default" mode. The expert user should perhaps be able to
> > > understand the different time bases for TDCx values and other timing parameters.
> >
> > ACK. This is also my intent.
> >
> > > And in a testing and evaluation environment the higher resolution of the Tc
> > > based TDCx values may also be a benefit. I. e. when reading the measured TDCV
> > > value to monitor the change of the delay over time and temperature.
> >
> > From your comments, I see two immediate actions:
> >   * Change the unit from time quanta to clock period (Tc)
> >   * Add a method to retrieve TDCV value when in auto mode
>
> That would be cool. Thanks.

That done in v4 of the series:
https://lore.kernel.org/linux-can/20210814091750.73931-1-mailhol.vincent@wanadoo.fr/T/#t

N.B. the changes are on the kernel size. I still need to prepare
a new series for iproute but that will be mostly some change in
the patch comments.

> > Right now, I am in holiday, with no access to my usual testing
> > gears.  I will prepare a version of the patches but you might
> > have to wait until August.
> >
> >
> > Yours sincerely,
> > Vincent
>
> Hope you had nice holidays ...

Yes. After more than two years, I could finally travel back to my
home country!

Yours sincerely,
Vincent
