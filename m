Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821163A0ED9
	for <lists+linux-can@lfdr.de>; Wed,  9 Jun 2021 10:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbhFIIov (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Jun 2021 04:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhFIIou (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Jun 2021 04:44:50 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0063CC061574;
        Wed,  9 Jun 2021 01:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1623228172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W4D/dpUy534xRRA2sZUtaIC4SgpgY4O+HXQSIzIZp78=;
        b=wZpvd7z4IROFubBJlsm4Cdhg4s60EYQpH/srv9SQcOFr4gjlGXjMpNLumJCry5GzJmEKD5
        sItdzdcgu4F6IRHcCbeYkvQsz6uVc5LRRjEBf4P9aI11fN4V39IVOiU7gng1csc6zXonu9
        M46ySd6MupUW426EEF+bNHyP/40E8x0=
Received: from [192.168.0.2] (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 5ed4e878 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Jun 2021 08:42:52 +0000 (UTC)
Subject: Re: [PATCH 5/5] can: flexcan: add mcf5441x support
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <20210608204542.983925-1-angelo@kernel-space.org>
 <20210608204542.983925-5-angelo@kernel-space.org>
 <DB8PR04MB6795CE1FF40605F69E3A0040E6369@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <CAMuHMdUeeH2BWgVRoVX7yfckY=wi8X3qkaH0THhVF_3FpZsbqg@mail.gmail.com>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <5f848026-fa3e-b50a-3d8d-2a047d429f65@kernel-space.org>
Date:   Wed, 9 Jun 2021 10:42:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUeeH2BWgVRoVX7yfckY=wi8X3qkaH0THhVF_3FpZsbqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Geert,

On 09/06/21 10:12 AM, Geert Uytterhoeven wrote:
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
> 
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
Thanks, fixed for v2.

> Gr{oetje,eeting}s,
> 
>                          Geert
> 

Regards,
-- 
Angelo Dureghello
+++ kernelspace +++
+E: angelo AT kernel-space.org
+W: www.kernel-space.org
