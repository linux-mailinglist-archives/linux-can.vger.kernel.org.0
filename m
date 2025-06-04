Return-Path: <linux-can+bounces-3777-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD88ACE5C6
	for <lists+linux-can@lfdr.de>; Wed,  4 Jun 2025 22:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BE23A83C5
	for <lists+linux-can@lfdr.de>; Wed,  4 Jun 2025 20:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F191DE2BC;
	Wed,  4 Jun 2025 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pa2bSoqG";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Fq+o4fuA"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A91C54AF
	for <linux-can@vger.kernel.org>; Wed,  4 Jun 2025 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749069278; cv=pass; b=Nqy4pTMqZhnpfAFhyfbrpnvqKZJDmpwXPPO9LJmo9rOrL/9RaCXR6zPVonljsV173qwDQt+NQHKkfRIdZK419bhfzd+IrMMR5wW4lQLzs95FZIsQkdUWgQU5yXHcxvhrZWFJOHPWrGTpNF1Ssd0siW4iiMOXMVZG+dRO00wTcis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749069278; c=relaxed/simple;
	bh=JNbXK0sEw9DHPudWWoBWQnk+yjDtFEgCYpmgysW8+oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPfV4pXtGbminnjhnQV8+qND0qBZNAM7APL4YBJDjtNSE7NJI3U5EuJ61OOIHttLGLEyxPOtVxKELMwH+6tZaEcREOhmVvaXtWkH8R3tg6kWpzNCFpc25M6+FxbPkxb9yX1aiepyBOzQPiRcBCm89hY2Z0MaPigj8+5sok2gXFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pa2bSoqG; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Fq+o4fuA; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1749069268; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YRBGbG+zBg9TVYKF5ibqnnmlvzeYYIVSsoaj6awgAHSIAUJ+LhuoaPGf3qhBhWz5VC
    scBmw4kAXLrxnoCk/pLNjyOsVJLrztYBAyV80Zq7nv1u7W+LZDw2tVZOojV2j2fgXATH
    vWala/BqajNSdZoHvNbSzEpqCykglEZf7PLdSr50C5w5wgVOyAbXAlnNpMDr33ahyuIE
    syRJKLHBYtReaPOsNLRs/NXh634KW4ojLrUA/A9eSofM1xu4VqwDe8uS0C7odfUXrKqE
    VlRM1y1G5GmVH8kz17WKKfUztFT/sv3y4JL0rTV/gKETSAkZHczY5zuTmvrAYxr4ezRP
    J6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1749069268;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=qizb5/Gq7bSROSKGPETrmMf5eUfrjBxOG4qBwiWlWgQ=;
    b=JhFzGKTsrbxBdM2+6Pa1zBmR2t3F7c9CJbtnHLVdgckxqihwt8RZ3GDWd89bHl2LR7
    9aLvWzpW7kNJVKCJOe8Z9I2kpYHba+r18yyhSwbxFx/naLuhsI4uLFvNsokuhUylKrYR
    v3p2g0lQHEItKNc66R850O/S+NvGVBzEdxwY+j/tW49UDauN5gtOUvNLGf2ZhtaHmQd4
    JTlZebB31qcqlTj3u5ci6zzdXuwRbLaOYIJsn0QGH976QUOjfEq+ISe0N08TiSnNDeAC
    4fJkGFUocs0zL7XAD6pW8Y7aFJY5yHu3B8rZc4INJeNolrirP6+dt864GsvZ03aprPgr
    Dy5A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1749069268;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=qizb5/Gq7bSROSKGPETrmMf5eUfrjBxOG4qBwiWlWgQ=;
    b=pa2bSoqGP6SRUTkWJYnBRhXjVJ0jClnESeP4KgqvsBEfuwEu3kz4V4OXSw2cWOwDMD
    0ZTUB9zASSyAr9E3VJSEPsyONpDxe6KxhV6081Nzyfj0jKKGjvCN9eejTBJO0aPvs0I+
    zO8DHP8YgLKDcqZFhfcnPcVn+NO1T7luojBOS6kZ83aBAQeM8Al3gN2rAhmtujbRr6Zn
    KC7f8F90GLkTKFnUxtcN1Cxz0j5rU81NafB/9kGbIfkFe3ST3rsE1V+VzLZh6ggROqZ0
    cD/NZ8MhKQtw/yZnj7SLI83GqG8hxGl2uIvvZx/EaK2aHWZ8puSlsDUdIkWTnSTg0fOD
    KRIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1749069268;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=qizb5/Gq7bSROSKGPETrmMf5eUfrjBxOG4qBwiWlWgQ=;
    b=Fq+o4fuAjxp6rK8BPHI6nWno6/Car0Ye0/h6gnm3jH9vqfXe5jC/qsfP2bHsScgkkQ
    PDX594tonEfkvHOv3XAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e5154KYSF1E
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 4 Jun 2025 22:34:28 +0200 (CEST)
Message-ID: <28e79f1a-e80e-41c7-b076-9407ff431aa7@hartkopp.net>
Date: Wed, 4 Jun 2025 22:34:22 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TR: can: canxl: about CAN_CTRLMODE_XL_ERR_SIGNAL
To: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <DBAPR10MB4187FB44B12BD9DB8B992256D4832@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
 <06bd3b3f-2665-4f19-b13d-581e57f54dfc@hartkopp.net>
 <AM9PR10MB4184729E14AD5C05ABC65718D496A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <DBAPR10MB41879125DC7369359E4AB256D467A@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stéphane!

On 28.05.25 09:51, Stéphane Grosjean wrote:
> Hi,
> 
> refs:
> [1] https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/can_xl_1/20220825_can_xl_vs_10base-t1s_v2.pdf
> [2] https://github.com/hartkopp/canxl-nl/blob/main/linux/0009-can-canxl-support-CAN-XL-error-signalling-switching.patch
> [3] https://github.com/hartkopp/canxl-nl/blob/main/linux/0011-can-add-CAN-XL-dummy-driver-DO-NOT-MERGE.patch
> 
> According to [1] on page 6, the mixed-CANXL mode (island 1) allows joint operation (aka CAN bus sharing) of CANFD and CANXL devices. This mode requires activation of the so-called “error signaling” mode.
> 
> Still according to [1] on page 6, the pure-CANXL mode (island 2) enables exclusive operation of CANXL devices on the same bus and is obtained by disabling the “error signaling” mode.
> 
> According to [3] lines 170-184, the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL flags are not mutually exclusive, so why introduce CAN_CTRLMODE_XL_ERR_SIGNAL [2] when the combinations of CAN_CTRLMODE_FD and CAN_CTRLMODE_XL would allow us to deduce this?
> 
> Indeed:
> 
> can_priv->ctrlmode & (CAN_CTRLMODE_FD|CAN_CTRLMODE_XL) ==
> 
> CAN_CTRLMODE_FD                    CANFD mode (n/a)

-> no CAN XL transceiver
CAN_CTRLMODE_XL = 0
CAN_CTRLMODE_FD = 1
CAN_CTRLMODE_XL_TRX = 0
CAN_CTRLMODE_XL_ERR_SIGNAL = 1 (fixed enabled)


> CAN_CTRLMODE_XL|CAN_CTRLMODE_FD    mixed-CANXL => error_signaling=ON

-> no CAN XL transceiver
CAN_CTRLMODE_XL = 1
CAN_CTRLMODE_FD = 1
CAN_CTRLMODE_XL_TRX = 0
CAN_CTRLMODE_XL_ERR_SIGNAL = 1 (fixed enabled)

 > CAN_CTRLMODE_XL                    pure-CANXL => error_signaling=OFF

-> this is correct with enabled CAN XL transceiver
CAN_CTRLMODE_XL = 1
CAN_CTRLMODE_FD = 0
CAN_CTRLMODE_XL_TRX = 1
CAN_CTRLMODE_XL_ERR_SIGNAL = 0 (fixed disabled)

But this is not complete IMO.

If you look at page 270 in
https://github.com/linux-can/can-doc/blob/master/x_can/xcan_user_manual_v350.pdf

There is a CAN XL only mode without CAN XL TRX switching.
And this combination allows error signalling or not.

So for our API this would look like this:
CAN_CTRLMODE_XL = 1
CAN_CTRLMODE_FD = 0
CAN_CTRLMODE_XL_TRX = 0
CAN_CTRLMODE_XL_ERR_SIGNAL = variable (default = 1 == enabled ?!?)

The fact that this mode has FDOE and XLOE set in the X_CAN controllers 
register seems to be misleading in comparison to our 
CAN_CTRLMODE_[FD|XL] handling. There is no 1:1 mapping.

Therefore I think CAN_CTRLMODE_XL_ERR_SIGNAL is still needed for CAN XL 
only mode without a CAN XL transceiver.

Maybe we should rename CAN_CTRLMODE_XL_ERR_SIGNAL to 
CAN_CTRLMODE_ERR_SIGNAL so that this mode is always visible for 
information purposes for all modes.

And it is only changeable for CAN XL only mode without a CAN XL transceiver.

Best regards,
Oliver



