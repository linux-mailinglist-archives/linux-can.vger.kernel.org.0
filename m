Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84C3276FF9
	for <lists+linux-can@lfdr.de>; Thu, 24 Sep 2020 13:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgIXLbG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Sep 2020 07:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgIXLbG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Sep 2020 07:31:06 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2787AC0613CE;
        Thu, 24 Sep 2020 04:31:06 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7280122F9C;
        Thu, 24 Sep 2020 13:31:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1600947062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9uiVuDlDurWMBLr4DK3ZvbWHNzJ3UuorXgrA6S7yTo=;
        b=ALBCS4kz/N/WYzAl+Gfzrx0IfLLa5cL3I2vF7nmngeS2eABzmOVm2TNFLrmsXdP0i1RPlR
        c61YLjyGNaPRgzTAECQKGS61p6D0xx+HQZlik8zLenvVbTXVMTPHkIRaBC/TSj3NgRj5BA
        V0/NwlJ7kG9i21VqnWXopznrvkLRmto=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Sep 2020 13:31:00 +0200
From:   Michael Walle <michael@walle.cc>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: ls1028a: add missing CAN nodes
In-Reply-To: <VE1PR04MB6687AC23E100D138FEDB012A8F390@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20200923095711.11355-1-michael@walle.cc>
 <20200923095711.11355-2-michael@walle.cc>
 <VE1PR04MB6687AC23E100D138FEDB012A8F390@VE1PR04MB6687.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <e9347e4c2e070ee9e8aa7a8007d89f02@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 2020-09-24 02:35, schrieb Leo Li:
>> -----Original Message-----
>> From: Michael Walle <michael@walle.cc>
>> Sent: Wednesday, September 23, 2020 4:57 AM
>> To: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; 
>> linux-
>> kernel@vger.kernel.org; linux-can@vger.kernel.org
>> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
>> Herring <robh+dt@kernel.org>; Marc Kleine-Budde <mkl@pengutronix.de>;
>> Joakim Zhang <qiangqing.zhang@nxp.com>; Michael Walle
>> <michael@walle.cc>
>> Subject: [PATCH 1/2] arm64: dts: ls1028a: add missing CAN nodes
>> 
>> The LS1028A has two FlexCAN controller. These are compatible with the 
>> ones
>> from the LX2160A. Add the nodes.
>> 
>> The first controller was tested on the Kontron sl28 board.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 18 
>> ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> index 0efeb8fa773e..807ee921ec12 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> @@ -386,6 +386,24 @@
>>  			status = "disabled";
>>  		};
>> 
>> +		can0: can@2180000 {
>> +			compatible = "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-
>> flexcan";
> 
> The explicit compatible strings cannot be found in the binding, but
> matched by the "fsl,<processor>-flexcan" pattern in the binding.  Is
> this considered to be acceptable now?

What is the consequence if it is not acceptable? replacing the pattern
with individual compatible strings?

-michael
