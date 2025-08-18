Return-Path: <linux-can+bounces-4258-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EC1B2A1FF
	for <lists+linux-can@lfdr.de>; Mon, 18 Aug 2025 14:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF10D2A10C4
	for <lists+linux-can@lfdr.de>; Mon, 18 Aug 2025 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5543218A9;
	Mon, 18 Aug 2025 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LvWEeSUU";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KqbKoXtQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0063218B8
	for <linux-can@vger.kernel.org>; Mon, 18 Aug 2025 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520547; cv=pass; b=RrtsMkLAo7qR4jUkWiHfhM6qzqiaK1fXyJv8OI1POhWN56x1Q9pS+U0O+Klw8E7jT1sm/rxw/pNJ7nDzc1NmLRHi+xKYi9i7uzm1dwui/bFTR15GkJ2q80gOKWRY6taACNsavog8K2Wl4vAJWyIIHqABoj+R9+42zW6HKHsj0/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520547; c=relaxed/simple;
	bh=dBGzmGF/dYfTzjXMob2HTgj+7JU07QXxfvchEPlzl7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBLhNgkvUCt0zY2s1ufDUu5xfcHHuUa25uuMe9dMVPavNsa4PfHjzC+LpahmVh0mH8j+4So094RdX3c7eRUbk9nDizuWNJIBTZDqVR9FXhHSJ05XTswtcgagu7yWSB+I7qYMNyWACUH6OlcyjGnpUt+do+xSgb8zX/tZP2Qd1B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LvWEeSUU; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KqbKoXtQ; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1755520534; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=F+SHN4ewgoNIRjKEtTtuZLBsxKusoCFwtu04xuu4xHg62i7ZYh6sVZSVXoiIkl59v9
    5JV65Gvi23uOJpBY+V2FaKvZV/f7POVxHTo9F7HVswLSuZiTo+VuL8nXwNKJ/jdpys+9
    dZjiDU8nIj9ZwYMycqFhwnlGozkQ9JbElw60BoUUwMriz7Hq9Y62cHQdTkYvulE8g0ex
    7tMz6fF+kVEhj4lFvUl2Ub364Ur62JIggZkU9CkdwBSXdHpBXaXzYuDHCfRUurhLwjcO
    10PE7cYy2nuJO/mLLzJH0pTnF/9K7b9A45G7CgYRF+5p2Y1HweOfhXiDDehRq8zjSw4l
    jgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1755520534;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EGY59YXb8vca0+c3vAxiDy6WdoKka/1gmV70JfXjgSA=;
    b=FdxaJPeCp0dwdyfvs/ofauQ84huyYLpjK2p5S2ssXOoBkRUPNApSbjzhly7lA83CHI
    pY6yhW7xiVtwsLPXMLt1OwIqSnnCeVm0a8fXYRaAViXQQKMpeb4tPfmXTd7Q1LgGoBnC
    sgct5SbOxCTJT5VOIrJJahWVKAVFA8Wa+BMkfTYMVrI+bButBpqTf8a4w9tOa9wE9YTK
    QlMfuIQhWnKDUaT5HkkXgTE3YCykgMHJD2U2HCIA5AOuSeULdhodrpHsgCFFtaQO8J5i
    88KvpBNVARMTb07aXNWed+oEqj05DQ3O5L8FCb/nd3kCX7d7SU2moZzlOXDdS5kvvrPx
    4x/g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755520534;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EGY59YXb8vca0+c3vAxiDy6WdoKka/1gmV70JfXjgSA=;
    b=LvWEeSUUMT6yl6iG1BVkm2rdzJ2W8WoD6JfT4cFaIAYVwar4Il5ftA6GPu8GK56afg
    SAB4IhmWqENIMtjSu08fFr+2LIeEzOPLEG+ftwd81e6iTauPti9ZHWipxSP6VnFlr8Wm
    2BD/7EtWYo9PGdCU/00iQasmGHTzYSd4jFsAINa88z1jRSuYcDwvT1EuavCJZJle3+lQ
    D/7bapPaedV1LkksRq4AXjN4NCoJdteZIUoRH8x2rc0JEr3IEYcZXaigfHF8XBFU57hu
    rmYf+4TbAx08keE4gYb/2MH1qN9LGQu7DDjGCHE2+Yiur9FdojiymeF6sVLIV+ho8fSQ
    YllA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755520534;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EGY59YXb8vca0+c3vAxiDy6WdoKka/1gmV70JfXjgSA=;
    b=KqbKoXtQlsWK2JzI0B5QTQyAJwpPx2pvcik0kHCmx43/CJ8HaeexRJmM9dxVokBCwQ
    8+f+KEF3/+QAeLa+6jDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5010::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d36117ICZYMep
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 18 Aug 2025 14:35:34 +0200 (CEST)
Message-ID: <a1a752e8-63ac-4a2c-998c-c88a223dd57a@hartkopp.net>
Date: Mon, 18 Aug 2025 14:35:28 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: canxl: add CANXL_PMS flag
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Robert Nawrath <mbro1689@gmail.com>
References: <20250729-can_tms-v1-1-21d0195d1dd0@kernel.org>
 <64bf8703-c80c-4a96-a5ad-0efc48bf0541@hartkopp.net>
 <d2610541-ba04-4a80-b3e6-c9c75bb1a486@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <d2610541-ba04-4a80-b3e6-c9c75bb1a486@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 30.07.25 16:15, Vincent Mailhol wrote:
> On Tue. 29 Jul. 2025 at 03:20, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

>> Btw. while we are at it: I would suggest for a name change of
>>
>> CAN_CTRLMODE_XL_TRX
>>
>> to
>>
>> CAN_CTRLMODE_XL_TMS
>>
>> as it makes clear how the controller should manage the PWM mode.
>>
>> "CAN_CTRLMODE_XL_TRX" would mean "there is a CAN XL PWM enabled transceiver"
>> available which tells nothing about whether the PWM mode is used or not.
> 
> Ack. I have the same opinion.
> 

We are already in 6.17-rc2 and I would definitely like to have the CAN 
XL driver support finalized in this net-next merge window phase.

What is your plan? Do you have an updated patch set to be posted for the 
discussion?

Best regards,
Oliver

