Return-Path: <linux-can+bounces-4492-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71252B45567
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 12:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DE1188CD12
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 10:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB11930C61C;
	Fri,  5 Sep 2025 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Sd89AzIX";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Cvfbcpxu"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92D230BB8B;
	Fri,  5 Sep 2025 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069718; cv=pass; b=CqFLTYP+foBtXQtTYCohDwbP0z4lvtKNDixnfykxGQuyKHchpdgxWI/tKPOwtAOkqLlRshTAnMHUW53SmdW8lC4Hq0QE3FyuwnegskP0Wk2hjnM8Ev7B7MMiKYGD960pdIIMPOAd7VbXyyYqpTW5dtfioqJIAWg0zZKQF19Z5jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069718; c=relaxed/simple;
	bh=LgekcvozZzBvKt3Qog2Rn/fs2BDInxuw373hvfXAK8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwwodiX71fWEe+xvDuGtuShGgEblmXEOnc9H4cLUATuUxuIJ8wRFgE41QUyHXiIS77h8A1j/SC9vj1WZFr0OpBq3ft3eW5TuXhx8KwTvJpXl27oIXuckvQTLnVPZRV5oIY86z0E3Ff8f4dckvh7dJ4WQWoXjVC2OEQ5VNztFtAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Sd89AzIX; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Cvfbcpxu; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757069708; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cSM1SxpF00pOL8IPPgmZmfIbgA3Aqo1cUxyXMeROlvY/k6jdMzVsU4Hy3+/2mSjmqi
    htKtDqyOQQDG03jb/8VbFSc4xnBlK67B0eC5Hc1w5x9bSuqLg25vpHkacNe56X8T7+6l
    Pn0g1thS6lzXMreodjr+frDMqD1XY/tkDn3pYP2+B16Mj2kbHh2EIO+5psAhgD7Tjt0T
    iEABAkFEPY3kkt0mpVW6c4rnL0N+xVGL8hk6mFRBq4JDeGmmJELj/9ha5ApOroHBGuLg
    H4irS+ZaZQ/clyV5z8gBRZkXySdvpElqP715DPKfxigoWPWgbnH4phAAq/S/qivRuhaI
    fVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757069708;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6NhZqsL4uJ9fGjeySJ5iCG+3q0rm80H4l54hcVLKDzE=;
    b=kZrlA3HJb8nVV/BoOEgSxcR59T5L4Z1x5D9wnv/5wiHoehMayHE3NcxotD8xEliHLm
    S9MNxWILSC1UN0gBLH0sBZ7THUHW4YWSNbTrULku9Hy3+c0FyqthRcvx44Yu4tSajLNp
    NRZqVlcSoKf6yayi/JbIyjtGJt4sdimvQm20SRG24swZjZesKfXOJED5HYfJtHbG+EWM
    YMeKFEtKE08dV6IFhLAl+pFY5cf0pfBt+d8XYBs5eUNIxTyXDafJR3cyTxlwVlPsAEAV
    falm2IvOqntD+d7zx0CQN/BAknJthbYN0b14qgX8VJfOhokHt0JtL0cjbleo+m+7qbju
    +5Jw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757069708;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6NhZqsL4uJ9fGjeySJ5iCG+3q0rm80H4l54hcVLKDzE=;
    b=Sd89AzIXMqyCn6F03gYhLvXa4AY+igJa6UxgHHD2MR3AMjsKj10Hc6b93Lk2OaXI50
    qAzH0H7rNatulQISI1+0KcEjvDiDg2Rcs5oSkNckytDLw6hJKmtiZ29tYCAMXRlW6Q4w
    4S/ir2Nxw6xtzxKEp3/byRrTFTO7RRFJWrHJ8ozJaN2X8Cylwb6Qm/OJm6u93RaBDy80
    TJ+nJ1nl13y+cfGWUMd0XHrVdbxIOAgy0iAaYT6HjOkbpnZyICw/JVMF38+SU4/rgGZF
    UPXj1ikGdKLGUJCFuZNkEuDIENDQSppztzl4/hxGM8sIF1kW7WIBGRHkyFZ51Vu/zoFX
    2T+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757069708;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6NhZqsL4uJ9fGjeySJ5iCG+3q0rm80H4l54hcVLKDzE=;
    b=CvfbcpxuwEjD8zUubmNlXzrX/U30rWs4gvLzFL7/3R3cbG+4HDsHKEn3uH7QtQCQnQ
    6SYGqBgM26Psa/yBraCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d361185At7RB9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 5 Sep 2025 12:55:07 +0200 (CEST)
Message-ID: <a4c0fade-52b6-4077-8a6a-fce6f2d62cd2@hartkopp.net>
Date: Fri, 5 Sep 2025 12:55:01 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/21] can: netlink: remove comment in can_validate()
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
 <20250903-canxl-netlink-prep-v1-7-904bd6037cd9@kernel.org>
 <b1bf6cc5-f972-4163-8619-e04b887e2d32@hartkopp.net>
 <79452f68-c231-4bf2-a4ea-e3dce9b78e2e@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <79452f68-c231-4bf2-a4ea-e3dce9b78e2e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04.09.25 11:48, Vincent Mailhol wrote:
> On 04/09/2025 at 15:51, Oliver Hartkopp wrote:
>> Hi Vincent,
>>
>> On 03.09.25 10:50, Vincent Mailhol wrote:
>>> The comment in can_validate() is just paraphrasing the code. When
>>> adding CAN XL, updating this comment would add some overhead work for
>>> no clear benefit.
>>
>> I generally see that the code introduced by yourself has nearly no comments.
> 
> I tend to disagree. While it is true that I added no C-style comment blocks, I
> added a ton of error messages which I would argue are documentation.
> 
> For example, this code:
> 
> 	/* If one of the CAN_CTRLMODE_TDC_* flag is set then TDC
> 	 * must be set and vice-versa
> 	 */
> 	if ((tdc_auto || tdc_manual) != !!data_tdc)
> 		return -EOPNOTSUPP;
> 
> was transformed into:
> 
> 	/* If one of the CAN_CTRLMODE_TDC_* flag is set then TDC
> 	 * must be set and vice-versa
> 	 */
> 	if ((tdc_auto || tdc_manual) && !data_tdc) {
> 		NL_SET_ERR_MSG(extack, "TDC parameters are missing");
> 		return -EOPNOTSUPP;
> 	}
> 	if (!(tdc_auto || tdc_manual) && data_tdc) {
> 		NL_SET_ERR_MSG(extack, "TDC mode (auto or manual) is missing");
> 		return -EOPNOTSUPP;
> 	}
> 
> Which I think is a huge improvement on the documentation. And this has real
> value because the user do not have to look at the source code anymore to
> understand why an
> 
>    ip link set can ...
> 
> returned an error.
> 
>> E.g. if you look at the [PATCH 12/21] can: netlink: add
>> can_ctrlmode_changelink() the comments introduced by myself document the
>> different steps as we had problems with the complexity there and it was hard to
>> review either.
> 
> Those comments are still here.
> 
>> I would like to motivate you to generally add more comments.
> This is a refactoring series. I kept all existing comments except of one and
> then added a more comments in the form of error message. I am not adding code,
> just moving it around, so I do not really get why I should be adding even more
> comments to the existing code.
> 
>> When people (like me) look into that code that they haven't written themselves
>> and there is not even a hint of "what's the idea of what we are doing here" then
>> the code is hard to follow and to review.
> 
> Is this an issue in my code refactoring or an issue with the existing code?
> 
>> We definitely don't need a full blown documentation on top of each function. But
>> I like this comment you want to remove here and I would like to have more of it,
>> so that people get an impression what they will see in the following code.
> 

No need to defend yourself with specific references or even feel 
personally attacked.

My overall feeling is that you spend an excellent effort in commit 
messages but this information is then omitted in code comments.

As I've already written "I would like to motivate you to generally add 
more comments.". And this can also happen when refactoring things where 
new functions are created which reduces the context to the original code 
section.

Best regards,
Oliver


