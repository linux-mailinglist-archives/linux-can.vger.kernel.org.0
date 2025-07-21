Return-Path: <linux-can+bounces-4016-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 935B9B0BDC8
	for <lists+linux-can@lfdr.de>; Mon, 21 Jul 2025 09:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C651F164F7F
	for <lists+linux-can@lfdr.de>; Mon, 21 Jul 2025 07:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23091283FF0;
	Mon, 21 Jul 2025 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="KO5z0zTU"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-67.smtpout.orange.fr [193.252.22.67])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF725283FD9;
	Mon, 21 Jul 2025 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083408; cv=none; b=HIUkukQSE8jfedK2sw1Uq5N6Y2wzEjK/8laSdpxdj6A+lS557I89kfz7VNvt2WIvGYT6X/b1py1qysTZuKfIW9IHXCVhORjVeYjS7qUOhMGDn42H+Wbln1VmvnTo3i2OSc9fJWa4L6bAaoZybUGTAYDE5goKIc3idiKWUezdOCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083408; c=relaxed/simple;
	bh=0T5uM75NWvtlhyGmeECcEh52vYNniLKCQIyVdTig//g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWd4KrkQ1O2yyQz8uU3vP4dOLhClEDR5IuYgwf7pXBY0cCjdKZeOSq+M7z/dy755prcCBe0Z0amfqgZz9KkUQIBcu/Q8Pka4/2fkWekZFr6OGPbUETcCOFKLAu9jY7RRkcNYYdZznRceyXsLF8McG3xFrRy+RL9VeqmZBKAenUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=KO5z0zTU; arc=none smtp.client-ip=193.252.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id dl3UuumIO01KBdl3VuD6wv; Mon, 21 Jul 2025 09:35:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753083332;
	bh=zOiYKF1SPgypvhuaANIQ7rNK2hL/Hn2Fhax3JnmXbN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=KO5z0zTUN2kGjc2S2K4Bv+iH8Y92yUqD/GRQVsUcPvZSaXiL4SdVDmxdwPlyLGakI
	 uV1PBqCNerWhcGtwgvVIAO3hzIaTpa8dmJdUXyTHZkhNKXFzR/8f36ZPJbgtIpiG6/
	 R+MQnKbNRdLZ4YPB69ovOT4kwKB3g7eDsMlNLpUVSwM6wySOuFChA+X1H+w/1SivTE
	 bQ9Y8srXE8NMS/RF86r4wD+4OGjqWmvWefeCw8xoywSFmCnklEgZ1/W8RIorWXJUXD
	 Q324srF4Qb2f4K+QJd9GTY4sASwOhIPTVzz5zyWlR+HwxRnMyV/YacktWcXluKYKUs
	 z0SjUvIuugWjA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 21 Jul 2025 09:35:32 +0200
X-ME-IP: 124.33.176.97
Message-ID: <a3507397-7166-4685-84c6-ba96ea2b2cd4@wanadoo.fr>
Date: Mon, 21 Jul 2025 16:35:23 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: tscan1: CAN_TSCAN1 can depend on PC104
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: "Andre B. Oliveira" <anbadeol@gmail.com>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250721002823.3548945-1-rdunlap@infradead.org>
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
In-Reply-To: <20250721002823.3548945-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/2025 at 09:28, Randy Dunlap wrote:
> Add a dependency on PC104 to limit (restrict) this driver kconfig
> prompt to kernel configs that have PC104 set.
> 
> Add COMPILE_TEST as a possibility for more complete build coverage.
> I tested this build config on x86_64 5 times without problems.
> 
> Fixes: 2d3359f8b9e6 ("can: tscan1: add driver for TS-CAN1 boards")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andre B. Oliveira <anbadeol@gmail.com>
> Cc: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


