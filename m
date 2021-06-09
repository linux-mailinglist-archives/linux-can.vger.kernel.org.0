Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04CE3A1553
	for <lists+linux-can@lfdr.de>; Wed,  9 Jun 2021 15:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhFINUg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Jun 2021 09:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231935AbhFINUf (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 9 Jun 2021 09:20:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1A3A613BE;
        Wed,  9 Jun 2021 13:18:39 +0000 (UTC)
Subject: Re: [PATCH 5/5] can: flexcan: add mcf5441x support
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Angelo Dureghello <angelo@kernel-space.org>
Cc:     "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <20210608204542.983925-1-angelo@kernel-space.org>
 <20210608204542.983925-5-angelo@kernel-space.org>
 <DB8PR04MB6795CE1FF40605F69E3A0040E6369@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <CAMuHMdUeeH2BWgVRoVX7yfckY=wi8X3qkaH0THhVF_3FpZsbqg@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <8e37464b-34ce-97bd-6422-ce723075bffb@linux-m68k.org>
Date:   Wed, 9 Jun 2021 23:18:38 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUeeH2BWgVRoVX7yfckY=wi8X3qkaH0THhVF_3FpZsbqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Geert,

On 9/6/21 6:12 pm, Geert Uytterhoeven wrote:
> Hi Joakim, Angelo,
> 
> On Wed, Jun 9, 2021 at 4:05 AM Joakim Zhang <qiangqing.zhang@nxp.com> wrote:
>>> From: Angelo Dureghello <angelo@kernel-space.org>
>>> Sent: 2021年6月9日 4:46
>>> To: gerg@linux-m68k.org; wg@grandegger.com; mkl@pengutronix.de
>>> Cc: geert@linux-m68k.org; linux-m68k@vger.kernel.org;
>>> linux-can@vger.kernel.org; Joakim Zhang <qiangqing.zhang@nxp.com>;
>>> Angelo Dureghello <angelo@kernel-space.org>
>>> Subject: [PATCH 5/5] can: flexcan: add mcf5441x support
>>>
>>> Add flexcan support for NXP ColdFire mcf5441x family.
>>>
>>> This flexcan module is quite similar to imx6 flexcan module, but with some
>>> exceptions:
>>>
>>> - 3 separate interrupt sources, MB, BOFF and ERR,
>>> - implements 16 mb only,
>>> - m68k architecture is not supporting devicetrees, so a
>>>    platform data check/case has been added,
>>> - ColdFire is m68k, so big-endian cpu, with a little-endian flexcan
>>>    module.
>>>
>>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> 
>>> --- a/drivers/net/can/flexcan.c
>>> +++ b/drivers/net/can/flexcan.c
> 
>>> @@ -637,13 +650,17 @@ static int flexcan_clks_enable(const struct
>>> flexcan_priv *priv)  {
>>>        int err;
>>>
>>> -     err = clk_prepare_enable(priv->clk_ipg);
>>> -     if (err)
>>> -             return err;
>>> +     if (priv->clk_ipg) {
>>> +             err = clk_prepare_enable(priv->clk_ipg);
>>> +             if (err)
>>> +                     return err;
>>> +     }
>>>
>>> -     err = clk_prepare_enable(priv->clk_per);
>>> -     if (err)
>>> -             clk_disable_unprepare(priv->clk_ipg);
>>> +     if (priv->clk_per) {
>>> +             err = clk_prepare_enable(priv->clk_per);
>>> +             if (err)
>>> +                     clk_disable_unprepare(priv->clk_ipg);
>>> +     }
>>
>> No need do this check, it will be handled in clk_prepare_enable() / clk_disable_unprepare(). So this change is unnecessary.
> 
> Except that the non-CCF implementation of clk_enable() in
> arch/m68k/coldfire/clk.c still returns -EINVAL instead of NULL.
> Any plans to move to CCF? Or at least fix legacy clk_enable().

That was a recent change, see commit c1fb1bf64bb6 ("m68k: let clk_enable() return
immediately if clk is NULL").

It could just as easily just return on that NULL check.

Regards
Greg



>>> @@ -2091,6 +2133,11 @@ static int flexcan_probe(struct platform_device
>>> *pdev)
>>>
>>>        devtype_data = of_device_get_match_data(&pdev->dev);
>>>
>>> +     if (pdata && !devtype_data) {
>>> +             devtype_data =
>>> +                     (struct flexcan_devtype_data *)&fsl_mcf_devtype_data;
> 
> Cast not needed?
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
