Return-Path: <linux-can+bounces-2197-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862779D6BD1
	for <lists+linux-can@lfdr.de>; Sat, 23 Nov 2024 23:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C084281E69
	for <lists+linux-can@lfdr.de>; Sat, 23 Nov 2024 22:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7A51632FA;
	Sat, 23 Nov 2024 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="J8writ5K"
X-Original-To: linux-can@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A5137C37;
	Sat, 23 Nov 2024 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732401278; cv=none; b=ImJXppwtkXs1jCCaEkEMOm9XvJDwNqKVrJ7e6LZD2W4BjnhYsa2ojnKTopRpQaSgEjNbDD0tSOSYTzv6Pzwh8df4c5DjU0+Q61j2ZTJq+1cDpBoVrP1f2bQzlvIGSFbwDR/Hgm64RKnUDoJRv2Ll+/LQp7Xmr9KXVxXg7/DbupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732401278; c=relaxed/simple;
	bh=vJLyd5CV9Q3EcZu7HOq2YoEHYZyCYMshmDYRfY4+e0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SidUlWQbKPc1Kul9w7LWuaoaNnJsokQYzVZj16BIzpcoKcrqcXvMJRto+Ew5a657++SIL3d8YISv+r/N9cMV7k+baF1CO1H3k1DpEBst2b6OwJvhqWmuKjAOrw9J/uIEnlBNmdyHZ9YoswrQoicIbPzjm/D8aVBXVTIBHF9giSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=J8writ5K; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C14C789411;
	Sat, 23 Nov 2024 23:34:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732401269;
	bh=XzKarSjMFUf5J8qcgDrsiCAIjbLo6AN+50f8iYPlELk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J8writ5KwDIYJfUXP1CTOq5NgMPMSW86cG8sWqz/eGDaRoT6HosrrqGzn8bW1AK5/
	 HhKaeqT4cU3rg0eyBlDl61En5P64bBRXiwrxzAGMb0/C8mBNvjQNegbPjHWWHBFFia
	 RBx7DDfSJxnNJrxbDG3+MiLJBHoULT3Z7RCvkV1ob43dBAk6tP0c5s0Cy+adK2kjm+
	 8wX34QcIW7WwvHzolk3znAY4brwIoUfg+tdc4jwyD/WpBdoOSeUpDRyJd7rAmWZbBw
	 b8Fl3HlhlIsf4Z8BxcOkK1eMbGKmdMnhpHjGCdTgiUv5jw3+nfhNLQBVcwsu54fuEm
	 VSOQOeheWAQdw==
Message-ID: <c7db1eb8-3ecd-4c21-a393-54130e4a4857@denx.de>
Date: Sat, 23 Nov 2024 21:14:41 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] can: ifi_canfd: fix {rx,tx}_errors statistics
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com, Marc Kleine-Budde
 <mkl@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org
References: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
 <20241122221650.633981-8-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241122221650.633981-8-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/22/24 11:15 PM, Dario Binacchi wrote:
> The ifi_canfd_handle_lec_err() function was incorrectly incrementing only
> the receive error counter, even in cases of bit or acknowledgment errors
> that occur during transmission. The patch fixes the issue by incrementing
> the appropriate counter based on the type of error.
> 
> Fixes: 5bbd655a8bd0 ("can: ifi: Add more detailed error reporting")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
The multitude of if (likely(skb)) in the patch is super-ugly, but I do 
agree the change itself seems valid to me, so:

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !

