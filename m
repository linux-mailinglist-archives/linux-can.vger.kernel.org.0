Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273543A42A8
	for <lists+linux-can@lfdr.de>; Fri, 11 Jun 2021 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhFKNEU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 11 Jun 2021 09:04:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:32838 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhFKNER (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 11 Jun 2021 09:04:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15BD1xxm043638;
        Fri, 11 Jun 2021 08:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623416519;
        bh=bMMWvzfrFHl4j9c+dznuq5O3XnvQE4Ox9cPFZYk/Sj4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jOzQ0IAB7U4Oxb4Ul/KKGQJuHkNxJDi8ysJpzq35QmUHfcdr2C/n9iSf4B52G3oMU
         lgSznlT7SZKzdeJmOgTkMV12AR1KnDYPlVuM1Smlor1lFr1IT5xxkPK4312qBseFoF
         OeG/i+ULj6x942viY0FRPcWyf5qYDebzuoolgVLo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15BD1xsY094056
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jun 2021 08:01:59 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 08:01:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 11 Jun 2021 08:01:59 -0500
Received: from [10.250.212.96] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15BD1sNC022485;
        Fri, 11 Jun 2021 08:01:55 -0500
Subject: Re: [PATCH v6 1/3] phy: core: Reword the comment specifying the units
 of max_link_rate to be Mbps
To:     Aswath Govindraju <a-govindraju@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210510051006.11393-1-a-govindraju@ti.com>
 <20210510051006.11393-2-a-govindraju@ti.com>
 <YLSNvUDJZ/v6NTuN@vkoul-mobl.Dlink>
 <615d3a2a-0dc2-0e87-fdac-e170542d33da@ti.com>
 <0150622f-8543-ac4a-fe18-f22d7862d163@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7913b08e-a71c-d29d-d921-c25a87c0616a@ti.com>
Date:   Fri, 11 Jun 2021 18:31:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0150622f-8543-ac4a-fe18-f22d7862d163@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On 11/06/21 6:12 pm, Aswath Govindraju wrote:
> Hi Vinod,
> 
> On 31/05/21 2:04 pm, Aswath Govindraju wrote:
>> Hi Vinod,
>>
>> On 31/05/21 12:48 pm, Vinod Koul wrote:
>>> On 10-05-21, 10:40, Aswath Govindraju wrote:
>>>> In some subsystems (eg. CAN, SPI), the max link rate supported can be less
>>>> than 1 Mbps and if the unit for max_link_rate is Mbps then it can't be
>>>> used. Therefore, leave the decision of units to be used, to the producer
>>>> and consumer.
>>>>
>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>>> ---
>>>>  include/linux/phy/phy.h | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
>>>> index 0ed434d02196..f3286f4cd306 100644
>>>> --- a/include/linux/phy/phy.h
>>>> +++ b/include/linux/phy/phy.h
>>>> @@ -125,7 +125,7 @@ struct phy_ops {
>>>>  /**
>>>>   * struct phy_attrs - represents phy attributes
>>>>   * @bus_width: Data path width implemented by PHY
>>>> - * @max_link_rate: Maximum link rate supported by PHY (in Mbps)
>>>> + * @max_link_rate: Maximum link rate supported by PHY (units to be decided by producer and consumer)
>>>
>>> So there are a few users of max_link_rate. It would be better that we
>>> document all previous users of max_link_rate that unit is in Mbps and
>>> then modify it here
>>>
>>
>> I was able to see that the max_link_rate attribute was used at,
>>
>> drivers/phy/cadence/phy-cadence-torrent.c:2514:
>> gphy->attrs.max_link_rate = cdns_phy->max_bit_rate;
>>
>> and in the bindings there is indication that the units to be used is Mbps.
>>
>> Can you please point me if there is any other place that I might have
>> missed to look at or that might need documentation update?
>>

The only user seems to be Torrent and max_bit_rate is documented well in
Torrent.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
