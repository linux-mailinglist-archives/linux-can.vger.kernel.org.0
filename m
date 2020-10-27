Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C51F29BC50
	for <lists+linux-can@lfdr.de>; Tue, 27 Oct 2020 17:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1800538AbgJ0Pr6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Oct 2020 11:47:58 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:31883 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758142AbgJ0PS2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Oct 2020 11:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603811905;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=i3cwSIo/oOXk4ZyzC9cZ9ci8cVVNUqz+r4VtJCdN+iM=;
        b=cI/OcKxNxZhiPnCwJe65rsVT9SSoo7KIKEpLVpFj6hQ6hugOAkMtfukhYT67g5upu+
        kYTubjReqPns1BblMsD3wvvSG6C2ig8s6ZtXAPE94FGLF4f8Vud9igTAG8pR5uILuE27
        f1AS2wL6bFjp26SYwU5as0dvSZU2MbpC2Ht7PeC+sLvCB5lWBEfqPDiHjDXX+RJOKIi+
        EFPO7sY2nZKGMAw3Nk0qwtIW+eY+oKP6FJJRhR91LBAjgfIVUWsPryfHvyRZDK7KzB/9
        CwYk/yVeRi4ujmmAh7hkRuRqIW8+mfDxErzZ18Vpqqm108ukCzTPbncoJRKr8ZtG1MSs
        u5Vw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8xvyl0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.2.2 SBL|AUTH)
        with ESMTPSA id j075f4w9RFIM3VK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 27 Oct 2020 16:18:22 +0100 (CET)
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame
 structure
To:     Marc Kleine-Budde <mkl@pengutronix.de>, mailhol.vincent@wanadoo.fr,
        linux-can@vger.kernel.org
References: <20201023203017.3485-1-socketcan@hartkopp.net>
 <d5ad34b5-7232-eadb-94a0-c58c111fa443@pengutronix.de>
 <8c142aa4-78a2-1291-b5a8-d4af9ba41338@hartkopp.net>
 <64920ca4-35df-2a46-5f1a-09a9e7eeffcf@pengutronix.de>
 <20201027144934.GA20013@x1.vandijck-laurijssen.be>
 <c404d7ef-43ce-6408-ac0d-34288eae2524@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <f88f06a1-a810-530b-12f5-667336cb7ef0@hartkopp.net>
Date:   Tue, 27 Oct 2020 16:18:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c404d7ef-43ce-6408-ac0d-34288eae2524@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 27.10.20 15:53, Marc Kleine-Budde wrote:
> On 10/27/20 3:49 PM, Kurt Van Dijck wrote:
>> On Tue, 27 Oct 2020 14:48:30 +0100, Marc Kleine-Budde wrote:
>>> On 10/27/20 2:23 PM, Oliver Hartkopp wrote:
>>>> On 27.10.20 14:06, Marc Kleine-Budde wrote:
>>>>> On 10/23/20 10:30 PM, Oliver Hartkopp wrote:
>>
>>>>
>>>> No. It is 'Classical CAN'. I'm not very happy with that naming as there
>>>> was already a 'CAN2.0B' specification to separate from the first version
>>>> which only had 11 Bit identifiers. This could be Ancient CAN now :-D
>>>
>>> So Classical CAN is CAN2.0B?
>>>
>>>>> For example there was a press release to harmonize the CAN transceiver nameing
>>>>> recently:
>>>>>
>>>>> https://can-cia.org/news/press-releases/view/harmonized-transceiver-naming/2020/7/16/
>>>>
>>>> Yes, there you can find:
>>>>
>>>> "CAN high-speed transceivers might be used in Classical CAN, CAN FD, or
>>>> CAN XL networks"
>>
>> What happened to 'Standard CAN' (<= CAN2.0A) and 'Extended CAN' (CAN2.0B)?
>> Did those names became fossils now?
> 
> As far as I understand Classical CAN is CAN2.0B

http://www.microcontrol.net/wissen/bus-systeme/can-fd/

As CAN2.0B covers CAN2.0A you are somehow right.

BR,
Oliver
