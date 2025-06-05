Return-Path: <linux-can+bounces-3781-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31069ACF135
	for <lists+linux-can@lfdr.de>; Thu,  5 Jun 2025 15:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83BAF7A77EF
	for <lists+linux-can@lfdr.de>; Thu,  5 Jun 2025 13:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F2E27146A;
	Thu,  5 Jun 2025 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aTUp/U78";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="fXqyMWjO"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B80270EAB
	for <linux-can@vger.kernel.org>; Thu,  5 Jun 2025 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131228; cv=pass; b=Puw9oj4J2QtNpZEQCOBitadJh4vjTNSGan55oN3uyRaH234PcXpDJM+Qqz90hTbbHR9oDDv/xJmfZBnaeSQdK2ZgcotLQ9+ksBQs1MIYdVmfjPF0wG0FoWMg0aDOGHBfnQf1oE7PH6eI8ANYlSsq6bv7jQp6rck18gsRmlH11oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131228; c=relaxed/simple;
	bh=CJBOh3bFUvKo18HNDkVVjIcl2T9/a3YdICZzMgq0NyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/ih7SEu79owcW2TAsQzjuADsQILDqzXf9idMjmI+IKI8sBpYEw3QVx0WDMMLuO0ywiZ/j/q1vuUdzJCcDV2PC60GmzHK4i3FNONylKguG92oUbkZaJEtpliqSK4WZdeQRAoJDmpby3liu2oupeEwyYO2m5Y4/k5UeUYpSKqLj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aTUp/U78; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=fXqyMWjO; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1749131217; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Sp29+v6PmnyG8D3cUbDmq5eGkNXe9vcE1VF7hHoZm6yJajMuPDRgWPZ4Y9Xhu++Cnx
    /m8xo5rMs7y6pF1kyYsvPcDmVF5TVahwXghkPUnZA6vJ8Td8vqBJvckoFvrnDjB1Chzw
    Oa5eANL7KSOTnj/2lyTQ24Z54nRkDTtV4LvdzdBuxLxjqDZ09429iwcecWN6B6XLVgfW
    rCe6j6rJ1vGHyP/YHuErIvfSmMymYbf1u6qqPwmxkcNNfZSEAR2bxQ7vD1y3pSQNP0hb
    dbKwaa/eJYisvXmzFkV6D37+XM3wB+gcakdInydKu4k38vixAOf/qCjyntu4oJHldPeJ
    YWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1749131217;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YBZlQ5/QPLBrklIcSKDvJ8p7AEHRBvZQaMnTvyB6ADs=;
    b=V6KfWu+LwvvDLCKyVdBOUJ7mHL5q54RnhVqfK8YoQ+2eVOC0POPCQ+aUZxMIKdAETb
    1I0rfJlMPzC3wufsUVruwJG4N6uvE5XMRPUrqQx/LwpbxQv/E65XaY40+vmvqvxscXZp
    wU8jO4ZmfSwSgczw4UbMbyvNwCT7QwmxAxmFCf2nuVFW7f+TW+DeAAWbGGhrJXTrBK+I
    IVVYXWTHaSAFJJWjUrPw5zYu023wEoj7wtvCfHZYWedHISM0E4LRERPqVn+n2zoPMuHq
    xklqsn2jUnNoK2tu8fWFTUt5Xie5Qo2PPeGC4xC6lM2jaOy5T2M0HhqWAj2TiNaiSqoY
    i4sQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1749131217;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YBZlQ5/QPLBrklIcSKDvJ8p7AEHRBvZQaMnTvyB6ADs=;
    b=aTUp/U786vMYr3Jb9vRAvBpim2pLa/iUCb5mHF/ZEDFqm254C79/VWkQQ5z6MGT109
    5Ydu1YWnhthj9WQQM7tIoNBRr6lU8TXDtYfX0x1I8ED/HUgiG+iWpeXPyFY+kMVGJXv/
    TqZlD1TfYHopGaR+zOO4gqAwcj3mh53ZOQ52oPgKyI3AKVvKVYaXOrnZL7TTWFsgIyUH
    2YNq1MSml61AXDOJkCIL5xf6YKe+G0j7JpLffZVo1+XDRAQZtNNkJ7WiZovkQ5cz7YXb
    eVIpvj6GiMy0MNPB5T6xX9H6GOjbwVXVuWCjBzjx4r6W8ABarwC64YPklRjxAo6yEHtf
    vwmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1749131217;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YBZlQ5/QPLBrklIcSKDvJ8p7AEHRBvZQaMnTvyB6ADs=;
    b=fXqyMWjOwNNzujBX4On9IC5ZAMIOycaOh/dPS/gCWlRsepAE8UwPumE9/gkpv5Nr0f
    cacnUmhV8ZXfY6jAqlBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e5155DkvSzr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 5 Jun 2025 15:46:57 +0200 (CEST)
Message-ID: <1c8e4057-d24d-4756-be1d-5513e5e95bcd@hartkopp.net>
Date: Thu, 5 Jun 2025 15:46:52 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TR: can: canxl: about CAN_CTRLMODE_XL_ERR_SIGNAL
To: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <DBAPR10MB4187FB44B12BD9DB8B992256D4832@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
 <1c502316-ddee-4f12-b0b8-3725cc522591@hartkopp.net>
 <AM9PR10MB418448751B1DA83EED7F50D4D498A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <63f2f51e-3fbd-4c8b-b7e4-29cb55246eaf@hartkopp.net>
 <AM9PR10MB41846346BC291F7CFE2CB71DD498A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <49245439-9822-449d-bf2c-5626349d909c@hartkopp.net>
 <20250527-lilac-panther-of-destiny-a13500-mkl@pengutronix.de>
 <AM9PR10MB4184E0842D24A4D7A2FEE09BD464A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <20250527-glistening-dog-of-apotheosis-293bd2-mkl@pengutronix.de>
 <04a7058c-95c7-4adc-a447-423aec0e0077@hartkopp.net>
 <DBAPR10MB418777613B630B9F72E20008D467A@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
 <DBAPR10MB41879125DC7369359E4AB256D467A@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
 <28e79f1a-e80e-41c7-b076-9407ff431aa7@hartkopp.net>
 <DBAPR10MB4187723379DAAEE390253778D46FA@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <DBAPR10MB4187723379DAAEE390253778D46FA@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stéphane,

On 05.06.25 12:02, Stéphane Grosjean wrote:
> Hello Oliver,
> 
> My point was not to claim a 1:1 relationship between (CTRLMODE_FD,CTRL_MODE_XL) and (FDOE,XLOE).

This was not my point. No problem.

> But to assume that:
> 
> CTRLMODE_XL => FDOE=1+XLOE=1+XLTR=0+EFDI=1 ("Operating in XL frame format only"...)
> CTRLMODE_XL|CTRLMODE_FD => FDOE=1+XLOE=1+XLTR=0+EFDI=0 ("Operating in all frame formats, without XL transceiver....")
> 
> and so on:
> 
> CTRLMODE_XL|CAN_CTRLMODE_XL_TRX => FDOE=1+XLOE=1+XLTR=1+EFDI=1 ("Operating in XL frame format only, enabling XL transceiver...")
> 
>> There is a CAN XL only mode without CAN XL TRX switching.
>> And this combination allows error signalling or not.
> 
> I'm sorry but I don't find this combination. But perhaps we don't understand each other on the term “CAN XL only mode”. Can you give me the FDOE,XLOE,XLTR,EFDI corresponding values please?

TMS (Transceiver Mode Switching)
ES (Error Signalling)

The restrictions are:

TMS=On => This is CAN XL only & ES=Off

Mixed Mode (CC/FD/XL) => TMS=Off AND ES=On
(When CC/FD are possible ES is always required)

But when no CC/FD frames are send but only XL frames with TMS=Off the ES 
can be On or Off.

Today when we enable CTRLMODE_FD the user can also send CC frames.

With CTRLMODE_XL this will change when it is set:

1. When CTRLMODE_FD is also set, we have a mixed mode which forces 
TMS=Off and ES=On

2. When CTRLMODE_FD is not set, we have a CAN XL only mode, where

2a. TMS=On => which forces ES=Off
2b. TMS=Off => where ES can be configured

And for case 2b we need the CAN_CTRLMODE_(XL_)ERR_SIGNAL configuration 
option.

I asked about these options today in a CAN CiA meeting and according to 
ISO these should be the possible configurations.

Best regards,
Oliver


> ________________________________________
> De : Oliver Hartkopp <socketcan@hartkopp.net>
> Envoyé : mercredi 4 juin 2025 22:34
> À : Stéphane Grosjean <stephane.grosjean@hms-networks.com>; Vincent Mailhol <mailhol.vincent@wanadoo.fr>; Marc Kleine-Budde <mkl@pengutronix.de>
> Cc : linux-can@vger.kernel.org <linux-can@vger.kernel.org>
> Objet : Re: TR: can: canxl: about CAN_CTRLMODE_XL_ERR_SIGNAL
>   
> Hi Stéphane!
> 
> On 28.05.25 09:51, Stéphane Grosjean wrote:
>> Hi,
>>
>> refs:
>> [1] https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/can_xl_1/20220825_can_xl_vs_10base-t1s_v2.pdf
>> [2] https://github.com/hartkopp/canxl-nl/blob/main/linux/0009-can-canxl-support-CAN-XL-error-signalling-switching.patch
>> [3] https://github.com/hartkopp/canxl-nl/blob/main/linux/0011-can-add-CAN-XL-dummy-driver-DO-NOT-MERGE.patch
>>
>> According to [1] on page 6, the mixed-CANXL mode (island 1) allows joint operation (aka CAN bus sharing) of CANFD and CANXL devices. This mode requires activation of the so-called “error signaling” mode.
>>
>> Still according to [1] on page 6, the pure-CANXL mode (island 2) enables exclusive operation of CANXL devices on the same bus and is obtained by disabling the “error signaling” mode.
>>
>> According to [3] lines 170-184, the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL flags are not mutually exclusive, so why introduce CAN_CTRLMODE_XL_ERR_SIGNAL [2] when the combinations of CAN_CTRLMODE_FD and CAN_CTRLMODE_XL would allow us to deduce this?
>>
>> Indeed:
>>
>> can_priv->ctrlmode & (CAN_CTRLMODE_FD|CAN_CTRLMODE_XL) ==
>>
>> CAN_CTRLMODE_FD                    CANFD mode (n/a)
> 
> -> no CAN XL transceiver
> CAN_CTRLMODE_XL = 0
> CAN_CTRLMODE_FD = 1
> CAN_CTRLMODE_XL_TRX = 0
> CAN_CTRLMODE_XL_ERR_SIGNAL = 1 (fixed enabled)
> 
> 
>> CAN_CTRLMODE_XL|CAN_CTRLMODE_FD    mixed-CANXL => error_signaling=ON
> 
> -> no CAN XL transceiver
> CAN_CTRLMODE_XL = 1
> CAN_CTRLMODE_FD = 1
> CAN_CTRLMODE_XL_TRX = 0
> CAN_CTRLMODE_XL_ERR_SIGNAL = 1 (fixed enabled)
> 
>   > CAN_CTRLMODE_XL                    pure-CANXL => error_signaling=OFF
> 
> -> this is correct with enabled CAN XL transceiver
> CAN_CTRLMODE_XL = 1
> CAN_CTRLMODE_FD = 0
> CAN_CTRLMODE_XL_TRX = 1
> CAN_CTRLMODE_XL_ERR_SIGNAL = 0 (fixed disabled)
> 
> But this is not complete IMO.
> 
> If you look at page 270 in
> https://github.com/linux-can/can-doc/blob/master/x_can/xcan_user_manual_v350.pdf
> 
> There is a CAN XL only mode without CAN XL TRX switching.
> And this combination allows error signalling or not.
> 
> So for our API this would look like this:
> CAN_CTRLMODE_XL = 1
> CAN_CTRLMODE_FD = 0
> CAN_CTRLMODE_XL_TRX = 0
> CAN_CTRLMODE_XL_ERR_SIGNAL = variable (default = 1 == enabled ?!?)
> 
> The fact that this mode has FDOE and XLOE set in the X_CAN controllers
> register seems to be misleading in comparison to our
> CAN_CTRLMODE_[FD|XL] handling. There is no 1:1 mapping.
> 
> Therefore I think CAN_CTRLMODE_XL_ERR_SIGNAL is still needed for CAN XL
> only mode without a CAN XL transceiver.
> 
> Maybe we should rename CAN_CTRLMODE_XL_ERR_SIGNAL to
> CAN_CTRLMODE_ERR_SIGNAL so that this mode is always visible for
> information purposes for all modes.
> 
> And it is only changeable for CAN XL only mode without a CAN XL transceiver.
> 
> Best regards,
> Oliver
> 
> 


