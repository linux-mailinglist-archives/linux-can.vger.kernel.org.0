Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6499D16FA40
	for <lists+linux-can@lfdr.de>; Wed, 26 Feb 2020 10:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgBZJJQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Feb 2020 04:09:16 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33844 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgBZJJQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2020 04:09:16 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01Q98kPl100212;
        Wed, 26 Feb 2020 03:08:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582708126;
        bh=715M2fEsQcQ9pGCNA+WdZUDo8i9Ym6s9zxFMk/XbQHM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CEG0EYD07SZfu0ZemKPihOoI30dStRLAC+bcraQqR//LNHsqF4Akstjvlb/UI5lY4
         54RSGgkjvojx/j0Cf2rAAZ2SD0nnTwpy+54VZG5VizfndJzvMQ2MKGcdIWrbBqX6Ll
         KlzqFMqsNnWT1ohsOhwZI4DsDIr00JJUYoGGAPHU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01Q98kCs075706
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Feb 2020 03:08:46 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 03:08:46 -0600
Received: from localhost.localdomain (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 03:08:45 -0600
Received: from [172.24.190.4] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01Q98fuI103976;
        Wed, 26 Feb 2020 03:08:41 -0600
Subject: Re: [PATCH v2 1/3] dt-bindings: m_can: Add Documentation for
 transceiver regulator
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <catalin.marinas@arm.com>, <mark.rutland@arm.com>,
        <wg@grandegger.com>, <sriram.dash@samsung.com>, <dmurphy@ti.com>
References: <20200217142836.23702-1-faiz_abbas@ti.com>
 <20200217142836.23702-2-faiz_abbas@ti.com> <20200219203529.GA21085@bogus>
 <a987bcd7-ca1c-dfda-72f3-cd2004a87ea5@ti.com>
 <20b86553-9b98-1a9d-3757-54174aa67c62@pengutronix.de>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <72e4b1f4-e7f1-cccd-6327-0c8ab6f9f9a7@ti.com>
Date:   Wed, 26 Feb 2020 14:40:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20b86553-9b98-1a9d-3757-54174aa67c62@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On 21/02/20 2:01 pm, Marc Kleine-Budde wrote:
> On 2/21/20 9:31 AM, Faiz Abbas wrote:
>> Hi Rob,
>>
>> On 20/02/20 2:05 am, Rob Herring wrote:
>>> On Mon, Feb 17, 2020 at 07:58:34PM +0530, Faiz Abbas wrote:
>>>> Some CAN transceivers have a standby line that needs to be asserted
>>>> before they can be used. Model this GPIO lines as an optional
>>>> fixed-regulator node. Document bindings for the same.
>>>>
>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/net/can/m_can.txt | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>
>>> This has moved to DT schema in my tree, so please adjust it and resend.
>>
>> Ok.
>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Documentation/devicetree/bindings/net/can/m_can.txt
>>>> index ed614383af9c..f17e2a5207dc 100644
>>>> --- a/Documentation/devicetree/bindings/net/can/m_can.txt
>>>> +++ b/Documentation/devicetree/bindings/net/can/m_can.txt
>>>> @@ -48,6 +48,9 @@ Optional Subnode:
>>>>  			  that can be used for CAN/CAN-FD modes. See
>>>>  			  Documentation/devicetree/bindings/net/can/can-transceiver.txt
>>>>  			  for details.
>>>> +
>>>> +- xceiver-supply: Regulator that powers the CAN transceiver.
>>>
>>> The supply for a transceiver should go in the transceiver node.
>>>
>>
>> Marc, while I have you here, do you agree with this?
> 
> I'll look into the details later today.
> 

Sure. Be sure to take another look at my attempt to use the transceiver
with a phy driver some time ago.

https://lore.kernel.org/patchwork/patch/1006238/

Thanks,
Faiz
