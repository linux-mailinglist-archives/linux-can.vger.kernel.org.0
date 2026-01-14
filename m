Return-Path: <linux-can+bounces-6134-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38393D1E105
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 11:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96A04303F742
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E602A38B7B2;
	Wed, 14 Jan 2026 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BMQRPq9r";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="uUmSE+Ci"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C03570AE
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386663; cv=pass; b=kX5Mi6C5mbu1SG0fgaO0Y14P8BcUmETfGGQOi4tzb4mBAuxOK9pNdNPfYfkdL2Bq6v8teAjWnohN14oROn+BYVI81h5kjwL9QUaDVJEg7Fr9sbF48z7hK8XDnajsdVJw9DBYM2DtySrfPW+U+yDqNr4PQBMEs6bW66tPBE6t9/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386663; c=relaxed/simple;
	bh=ubed5J1no5SvfV2+I6qUN7BbUSY7r1W81m1OH+oDfBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDeI4UOOj22Dc24dmatHa78HUAbTgEFM06x/7I9YllIRv/xGhXIsV/e5ErvIT2oPYpj3B+Qc0pI+7rFNUHCzyaoBy7EY+iUdP9nyPq2M74UfOmwkBcm0Lxw5Vrrdar80kHqREhbx0vTsDdfZ3mzF3z8jGkzP7W2TT+Rq7K7EmYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BMQRPq9r; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=uUmSE+Ci; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768386659; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LovM+8CW7BTY0VwXP5drB09FE779GgH2oiEorUi9zGQ8xHy9nhouuaOPxUEEHyIpvt
    gm6uCon56WmTJ3iUdb1dZJbGuFj9kVVnE3o3c10IuPW+DPqJlXgbGSITBNVlg+mSIGAV
    mvEgLrINFdWvmaN8RnOLXcZU0ygQxkXO1x9rEUUQRxc73RLefAAs7opfrxBGjLeIW5ky
    PpnAW2O9GqogySdVQAfSzrR0iSJU/3wijFF50RECGPiNw50EYPmhYkKvTdMBdGhXchbO
    lmZYYkeUr49kVkud20KetC+oq0YcjeEYjQHajE/ShobIXUmbuue8+FWTFPv7pudwGg9e
    yFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768386659;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fag6HfV8XlblZAuwt28L9Z/i9Za4uvUqwGaf1VH3RH0=;
    b=lQC90Bi3mp2HDo2SePZTot+kzPSszzGoFDQEk1XunAMKLsuHBMfTyN2hI11aCIDDVJ
    nz5COQk8oqJ6hfYKgfi3zVrSoZRwYgpRUytb6q2M/THwZ1l19YkAKmsliZQxMCnsRgqF
    M3a0pysk0xi5InS0DDITS/MyQ0KQERx7XEYgnyX4EjAPnHMKLG7S9SOuCCEmTOVrOl9l
    8cw1qb2dpv7rlTbg7ByNVcHu3KZfec1Ov/OnawVVs2g0rGhtSFgIxijs3k+XPLD9a945
    Q0bwX+8vtWT4U1ArpmpEqai+nea8ia5oqp9+UFBsaPWeEugDzU6OBZ6FCciZYLFyEMtH
    lT1Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768386659;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fag6HfV8XlblZAuwt28L9Z/i9Za4uvUqwGaf1VH3RH0=;
    b=BMQRPq9rJGgzIzkikuOCCdj5xFoHMd1iUoqJW7FuiXuu7PUsC9vcy7ZQkZEDJaTtlz
    hWc+9M8xTNNUnJkUzsuPKF36jIjTk2C1Pp4VxfouxFRATmJJ/WqEoXFO3BX/OPCOqgPk
    WZWCSjuXLDpMyWaq+1fYtuPB7k7tFWpNysengUPhUGRpQ60sjXpfctoloLNRO8z0r//p
    khXjwz2rAXqB2JzS4ubMouuAmTIrTj8gwB5bXYyuhjVP3TlN4AvvRwrEJw8UDHdib6TE
    Q+2xaRx7qROS7bfsTMCrDFQ2t6pFhc5K0PunMvoe09UiTTq9J0PS8gQQwzMy9OMtpAgK
    UBQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768386659;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fag6HfV8XlblZAuwt28L9Z/i9Za4uvUqwGaf1VH3RH0=;
    b=uUmSE+CicSQ3aHuZWwZZY/RYJ3A5fEfjfcYkUdTjAJO6rTqM2uqTgRLyD7sUx66b/J
    Rb8rRJkupEycA731huAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6800::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20EAUxrqy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 14 Jan 2026 11:30:59 +0100 (CET)
Message-ID: <e2cadc66-0c11-4651-a2e2-b272d8ed598b@hartkopp.net>
Date: Wed, 14 Jan 2026 11:30:59 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can 0/5] can: usb: fix URB memory leaks
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de
References: <20260110-can_usb-fix-memory-leak-v1-0-4a7c082a7081@pengutronix.de>
 <5b5c8a8b-5832-4566-af45-dee6818fa44c@hartkopp.net>
 <20260114-offbeat-impala-of-finesse-df5c4c-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260114-offbeat-impala-of-finesse-df5c4c-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14.01.26 11:19, Marc Kleine-Budde wrote:
> On 14.01.2026 11:04:11, Oliver Hartkopp wrote:
>> does this patch set need to be reworked due to this (AI) feedback from
>> Jakub?
> 
> yes
> 
>> https://lore.kernel.org/linux-can/20260110223836.3890248-1-kuba@kernel.org/
>>
>> The former/referenced PR has been pulled - so that specific patch might to
>> be fixed again, so that usb_unanchor_urb(urb) is called after
>> usb_submit_urb() ??
> 
> yes, probably. I'll look into that later this week (hopefully).

Thanks.

Can you probably send a linux-can PR for the

Revert "can: raw: instantly reject unsupported CAN frames"

https://lore.kernel.org/linux-can/20260101191330.1836-1-socketcan@hartkopp.net/

patch set in the near future?

The

[can-next 0/5] can: remove private skb headroom infrastructure
https://lore.kernel.org/linux-can/20260112150908.5815-1-socketcan@hartkopp.net/

patches are based on that patch set which needs to be merged into 
net-next before.

Best regards,
Oliver


