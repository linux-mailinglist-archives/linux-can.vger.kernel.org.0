Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBDD2752B7
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 10:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIWIC4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 04:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWIC4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 04:02:56 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ACBC061755
        for <linux-can@vger.kernel.org>; Wed, 23 Sep 2020 01:02:56 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 978B723E3F;
        Wed, 23 Sep 2020 10:02:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1600848172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hryNUXUVE7sqrOsR+Q+ZEre8IiXXW7zf305nNamYJRQ=;
        b=CdYNL2oEuWruXN3FGvhdwg93l2cQG538S0ButXBTTD2kfvQ9+fCqvHryeF922CtDVc4KAg
        dO5oL4VmHGAHpxqSElyFDTpwMHN+DrovF5KAqwtjQXicswBFhg0U0juxMoZB3tJ9jpcsum
        A4r8ydSUCtH9mdwUrVuc2M5eOo9NVPA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Sep 2020 10:02:52 +0200
From:   Michael Walle <michael@walle.cc>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     qiangqing.zhang@nxp.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org
Subject: Re: [PATCH 20/20] can: flexcan: add lx2160ar1 support
In-Reply-To: <5b3c07ab-ca8c-d43d-f4e0-7155d358648d@pengutronix.de>
References: <20200922144429.2613631-1-mkl@pengutronix.de>
 <20200922144429.2613631-21-mkl@pengutronix.de>
 <4ffe89fbb4c91a9587622862c3509180@walle.cc>
 <5b3c07ab-ca8c-d43d-f4e0-7155d358648d@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <0e90e8234d38830749ad8de380837eb2@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 2020-09-23 09:54, schrieb Marc Kleine-Budde:
> On 9/23/20 9:45 AM, Michael Walle wrote:
>> Hi Joakim, Hi Marc,
>> 
>> Am 2020-09-22 16:44, schrieb Marc Kleine-Budde:
>>> From: Joakim Zhang <qiangqing.zhang@nxp.com>
>>> 
>>> The Flexcan on lx2160ar1 supports CAN FD protocol.
>>> 
>>> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
>>> Link:
>>> https://lore.kernel.org/r/20190712075926.7357-9-qiangqing.zhang@nxp.com
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> ---
>>>  drivers/net/can/flexcan.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>> 
>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>> index 5f778c961a0c..e86925134009 100644
>>> --- a/drivers/net/can/flexcan.c
>>> +++ b/drivers/net/can/flexcan.c
>>> @@ -216,6 +216,7 @@
>>>   *   MX8QM FlexCAN3  03.00.23.00    yes       yes        no       no
>>>      yes          yes
>>>   *   VF610 FlexCAN3  ?               no       yes        no      yes
>>>      yes?          no
>>>   * LS1021A FlexCAN2  03.00.04.00     no       yes        no       no
>>>      yes           no
>>> + * LX2160A FlexCAN3  03.00.23.00     no       yes        no       no
>>>      yes          yes
>> 
>> I'd really like to see LS1028A support. At the moment, I'm having the
>> following additional patch for the ls1028a device tree.
>> 
>> can0: can@2180000 {
>>      compatible = "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-flexcan";
>                                               ^^^^^^^^^^^^^^^^^^^^^
>>      reg = <0x0 0x2180000 0x0 0x10000>;
>>      interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
>>                    clocks = <&sysclk>, <&clockgen 4 1>;
>>                    clock-names = "ipg", "per";
>>                    status = "disabled";
>> };
>> 
>> Do we need to add a dedicated compatible entry for the LS1028A
>> the driver?
> 
> At the end of the series, there are the following compatibles:
> 
>> static const struct of_device_id flexcan_of_match[] = {
>> 	{ .compatible = "fsl,imx8qm-flexcan", .data = 
>> &fsl_imx8qm_devtype_data, },
>> 	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, 
>> },
>> 	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, 
>> },
>> 	{ .compatible = "fsl,imx53-flexcan", .data = &fsl_imx25_devtype_data, 
>> },
>> 	{ .compatible = "fsl,imx35-flexcan", .data = &fsl_imx25_devtype_data, 
>> },
>> 	{ .compatible = "fsl,imx25-flexcan", .data = &fsl_imx25_devtype_data, 
>> },
>> 	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, 
>> },
>> 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, 
>> },
>> 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = 
>> &fsl_ls1021a_r2_devtype_data, },
>> 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = 
>> &fsl_lx2160a_r1_devtype_data, },
>                          ^^^^^^^^^^^^^^^^^^^^^
>> 	{ /* sentinel */ },
>> };
> 
> The compatible of your can device matches the one listed in
> the driver. So there's no need for the "fsl,ls1028ar1-flexcan"
> in the driver.
> 
> If it turns out, that the "fsl,ls1028ar1-flexcan" needs
> different handling than the "fsl,lx2160ar1-flexcan", we would
> add it with different quirks to the driver.

That was what I was asking. Ie. if Joakim already knows any and
if it makes sense to have some added right now.

And maybe you/he want to see the LS1028A added to the table in
the header of the file. I've had a look at the vendor manual but
couldn't even find the IP version. Seems to me that only Joakim
is able to fill out that row ;)

-michael
