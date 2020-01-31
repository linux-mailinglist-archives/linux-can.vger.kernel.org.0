Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C6014F14D
	for <lists+linux-can@lfdr.de>; Fri, 31 Jan 2020 18:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgAaRbL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 31 Jan 2020 12:31:11 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55844 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgAaRbL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2020 12:31:11 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00VHV36s087335;
        Fri, 31 Jan 2020 11:31:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580491863;
        bh=Gt5dd7XOIRcUxh6uvWBlZM+92xMNDI0LZYHC+I8v0Yc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=M4gREsBxtBTZzWFlbEJzezhFWLdaORzgSPq+7+d08L2iDdkdonMyzrF2XDxXWcq1J
         VbBBh3wXz0AWxkGag23GOKlr3Vhig1fvjsTxg3qL7Py70/JONWvb19yxwkvMIxrlgo
         phE5EXxmjYPV3AQPHMi7GieUayWb+rNJ8uaLJ8bg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00VHV3HD096950
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jan 2020 11:31:03 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 31
 Jan 2020 11:31:03 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 31 Jan 2020 11:31:03 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00VHV3pe063654;
        Fri, 31 Jan 2020 11:31:03 -0600
Subject: Re: [PATCH v2] can: tcan4x5x: Turn on the power before parsing the
 config
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20191210163204.28225-1-dmurphy@ti.com>
 <4a2e80f0-13c5-df7b-65af-25f86ca48f2a@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <db84cce8-925e-0b31-e196-6543359e6ea5@ti.com>
Date:   Fri, 31 Jan 2020 11:27:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4a2e80f0-13c5-df7b-65af-25f86ca48f2a@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

On 1/2/20 6:38 AM, Marc Kleine-Budde wrote:
> On 12/10/19 5:32 PM, Dan Murphy wrote:
>> The parse config function now performs action on the device either
>> reading or writing and a reset.  If the regulator is managed it needs
>> to be turned on.  So turn on the regulator if available if the parsing
>> fails then turn off the regulator.
> Another BTW:
> Consider converting the switching of the vsup to runtime_pm.
>
> Yet another one:
> Why do you disable the clocks in the error path of tcan4x5x_can_probe(),
> but never enable them?
>
>> out_clk:
>> 	if (!IS_ERR(mcan_class->cclk)) {
>> 		clk_disable_unprepare(mcan_class->cclk);
>> 		clk_disable_unprepare(mcan_class->hclk);
>> 	}
> - please move the clock handling from the m_can.c to the individual
>    driver
> - please move the clock handling to runtime_pm in the individual driver
> - remove the obsolete m_can_class_get_clocks()
> - make runtime_pm mandatory
>
> regards,
> Marc
>
I have separate the clock calls into pm runtime calls and moved the 
clock init into the respective children of the framework.

Did you want me to submit 1 patch with all the changes or would you like 
3 separate patches?  First 2 patches will abstract the clocks away into 
the children and the 3rd patch would be to remove the clocks API from 
the framework

Dan

