Return-Path: <linux-can+bounces-3884-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A13FAE270C
	for <lists+linux-can@lfdr.de>; Sat, 21 Jun 2025 04:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775B35A427A
	for <lists+linux-can@lfdr.de>; Sat, 21 Jun 2025 02:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E59E1487ED;
	Sat, 21 Jun 2025 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lImFEwpT"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34EA55;
	Sat, 21 Jun 2025 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750472104; cv=none; b=mBug0PDIuDMW6pg306eDqj34r+WXPEleLRtP0RxqdT6n8HIDOsBTxFPmmD7PRZPBA9sGQKoXhe8v8ABAhP0cbe2B5uKklIW1JgZ6T9hVBtO+U/R2x3gRliCdOAnDqP9DlS1+plOlFEVJj33c5FpPBcQ6MtCJYxO9ooXITbdaLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750472104; c=relaxed/simple;
	bh=v+bqdAnt03R+qfCBgcEfp0EzJfTLosT5QYIdyj8W1sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8cDbyg8Y5tmxaTuOK8/ZaM4cm85HPjeNgIbq+/3LFN5UYgnoFygZEWER7m/sp4OWxNQiXNysMXR4ZOS8oX38GOSIGqqPFkZd3AFm3RSuoEZB2uQY481qOuBs3zF7pcKyGkQFpr5GayJ5K34D+F2ZlLVEv/A1NQeh/Y9+xyBRkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lImFEwpT; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id SnjauyS4tCQ8aSnjcuFLaF; Sat, 21 Jun 2025 04:13:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750472020;
	bh=v+bqdAnt03R+qfCBgcEfp0EzJfTLosT5QYIdyj8W1sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=lImFEwpTWMOa6cu3Mri8QVejOKQMOoeXuNL4SsA6x6N/HF24D4u4OnElzREx4yc8e
	 W/4ZTDem/CQlQuLCVmlzP66m8Fa+qw8kGvMGW03iyn9VQCYPBq5ZgKSa8W+E8y9pT6
	 txEGskZhGWrLauvR+nzz2KJzRCwUCw8scw0gV7x32OmOLnqYHeCazY/yW1+stJmdmf
	 QhMjyHnSpb+P2mHNswRdQX59zmHIMyPEio5IhStM/JCq4nfiVLR53YJUWmiRREfJl5
	 Fa/03nVxifi9IkHE6DhLFFNMM46bLK4G7MD0NfBgpN4kGSFmVHX4o+uPHk7OyJRIwq
	 vNqGFX96JDViA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Jun 2025 04:13:40 +0200
X-ME-IP: 124.33.176.97
Message-ID: <d855c26a-1982-4fc6-9333-93df4a5a98d9@wanadoo.fr>
Date: Sat, 21 Jun 2025 11:13:33 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: m_can: apply rate-limiting to lost msg in rx
To: Sean Nyekjaer <sean@geanix.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Fengguang Wu
 <fengguang.wu@intel.com>, Varka Bhadram <varkabhadram@gmail.com>,
 Dong Aisheng <b29396@freescale.com>
References: <20250620-mcan_ratelimit-v1-1-e747ee30f71f@geanix.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250620-mcan_ratelimit-v1-1-e747ee30f71f@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/06/2025 at 19:00, Sean Nyekjaer wrote:
> Wrap the "msg lost in rxf0" error in m_can_handle_lost_msg() with
> a call to net_ratelimit() to prevent flooding the kernel log
> with repeated error messages.

Note that another solution is to simply remove the error message. The users can
use the CAN error frames or the netstasts instead to see if lost messages occurred.

That said, I am OK with your proposed patch. See above comment as a simple FYI.

> Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


