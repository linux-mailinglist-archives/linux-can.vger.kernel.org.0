Return-Path: <linux-can+bounces-3727-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775BBAC7518
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 02:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16BC3A86A0
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 00:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3F51AF0C8;
	Thu, 29 May 2025 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Rdh+wsfo"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB592DCBE3
	for <linux-can@vger.kernel.org>; Thu, 29 May 2025 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748478681; cv=none; b=p5j7yl5WYibvfSquh4iVvxiMPBzk46dIQ/8vdsCxKgyf0WISoCuE+LsyUMgmxIZBmQRpmutFBvnYPAeSxqO0WBlfT60oPUv+t71yY9X7gnTQ9zBbYVBfbIBEcl4DklZI6fF1SoqyHIgiLSFQkNlC/kCMlfEojySX3NpS1vkieTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748478681; c=relaxed/simple;
	bh=6jKQFrXDlrlQOBfI3n2jNCV5Bq67JqYcb72VuK5n7c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4iU+ylkhdOo96km/92nfiAX7rFq4+6iQGig4/iromH2XEKQLJv6e1BeAF3bFqSaRtsUD5g0q2wwBUFb39AIl4HmO0tvdMoDof5WeHKVAUYCvyiwXZhOpjVRwDWGKsM2ApwFy4mSqB08gmgrDx1HHqwLNRHShE3R1fPTkRBBq4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Rdh+wsfo; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id KR9kuj7YtyzREKR9mu7RPk; Thu, 29 May 2025 02:30:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748478603;
	bh=6jKQFrXDlrlQOBfI3n2jNCV5Bq67JqYcb72VuK5n7c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Rdh+wsfoqij9nPwoT0EIFLi9vgFJosZ7dTmf37KHf/y6hMAlt5RI8OK+0Uab4Zg2m
	 SYZxIgiXyRDr20CoS02xJm5c2mh+cK6EkyKxxYtlIVdKt+01QAM/eMr1hoX9+24d/Z
	 fYZZkidEW3FTTvBWYG0VGL/XmJwMFgDtLCwcWjobmRiey+JSu1rAK0MhZCen8sUPpL
	 1xuxexByKeGCGpE5fbgrf/+3t4BjrE7O3EeU4ew7W0noG3pwIMfL3WiQ7ZwsSvDWYK
	 a+cxqecAci08VPdn4s4xzQiMGMwt73iR73dNzhAGzvvMpp5jFhul1/Gv6zVIosY8Yn
	 JY48r8JTuF4rQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 29 May 2025 02:30:03 +0200
X-ME-IP: 124.33.176.97
Message-ID: <08729038-a486-4ec7-b373-deb525cab231@wanadoo.fr>
Date: Thu, 29 May 2025 09:30:00 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] can: netlink: replace tabulation by space in
 assignment
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <20250527195625.65252-1-socketcan@hartkopp.net>
 <20250527195625.65252-2-socketcan@hartkopp.net>
 <20250528-quirky-ultra-hawk-37000f-mkl@pengutronix.de>
 <77c5a904-8b2c-4a78-890d-2777ddefe250@wanadoo.fr>
 <20250528-bronze-penguin-of-joviality-0ce1a8-mkl@pengutronix.de>
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
In-Reply-To: <20250528-bronze-penguin-of-joviality-0ce1a8-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/05/2025 at 01:12, Marc Kleine-Budde wrote:

(...)

> I've adjusted the cover letter, as patch 1 is already mainline, and
> taken the rest of the series to can-next/testing. Note, once -rc1 is
> out, I'll rebase this branch.

Perfect! That's helpful, thanks!


Yours sincerely,
Vincent Mailhol


