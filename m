Return-Path: <linux-can+bounces-3823-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20541AD66AC
	for <lists+linux-can@lfdr.de>; Thu, 12 Jun 2025 06:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8CC1894042
	for <lists+linux-can@lfdr.de>; Thu, 12 Jun 2025 04:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1B31A0BC9;
	Thu, 12 Jun 2025 04:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fwbrXYjB"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-15.smtpout.orange.fr [193.252.22.15])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70219F137;
	Thu, 12 Jun 2025 04:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749701499; cv=none; b=T7Pd/boBXL4x69IAS5RSkDTB1obtU//tT6m5rGKp2xsNJJdewyQSefw7u8q1iQ2QU+jOWt0nZhcofY+5/LsxHtdyytJcO8tPHKTY2M7RjyaCr67DHJfsTNqry2LFK84yP/w90jFaGfyQAIuQnI2hu0Z9nBDTgAD57W4oQZDwzPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749701499; c=relaxed/simple;
	bh=wls3N1wBpnRb7xoE9FQ9bXwFQVN++wR/N0IaSoxO4zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/mlDPO9z4CozZddGr4oHa9v6IDePw90Tz8l1MU7BcDFhPfjQTzy+cmLRqZNP7aKfHNCKa68NV8wGCo0AETk/yNHg8Uf+5MI3tSPL6EKqgD2G1A0DduKtZSg8C3M/Sj/70+FhhsX31cQ1zim00StwFqmk/P5AFlUMmDN9xgI5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fwbrXYjB; arc=none smtp.client-ip=193.252.22.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id PZ8vuqDNnk261PZ8wu1B5V; Thu, 12 Jun 2025 06:02:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1749700946;
	bh=ISU1PiIvYv6KOAeAGCuwB/xGOXrgtpGZ76PeuBD7VQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=fwbrXYjBfD1o1yZP+uhrhZsywKBuE0tGqTPnWfEBxqsQmscl2qtArOBNGIePM+p6c
	 GDYL4W7VmfPmmBEB/5WhcSC1srYd0PGc0KvqEY91xvLovwaM3fJAq9E+FjZtCLbNkf
	 q0tqi12Fl06aGYJeARXrxQTeJQG/UiOloIeYSUHs2yw1crXJyjYy9eK88SvupFflta
	 2oAb4y2HqVoekWchSDrS1xK/Vp8bq4kaMXWI4jF0gAp18Y0aOZzE/mRbr39l6wkJTT
	 aSXFWPA4JE6Ynll969F6kVeZTLgqpqG57ku6HNQvgkHeaY2bICCq/6Tdpwke+1md9Y
	 cbpNysWaH8k+A==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 12 Jun 2025 06:02:26 +0200
X-ME-IP: 124.33.176.97
Message-ID: <2c49e811-5271-4859-ad7c-36bb40d55aef@wanadoo.fr>
Date: Thu, 12 Jun 2025 13:02:20 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] can: rcar_canfd: Remove bittiming debug prints
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <cover.1749655315.git.geert+renesas@glider.be>
 <a8b9f2c8938dc5e63b8faf1d0cdc91dadc12117e.1749655315.git.geert+renesas@glider.be>
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
In-Reply-To: <a8b9f2c8938dc5e63b8faf1d0cdc91dadc12117e.1749655315.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/06/2025 at 00:37, Geert Uytterhoeven wrote:
> There is no need to have debug code to print the bittiming values, as
> the user can get all values through the netlink interface.
> 
> Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Yours sincerely,
Vincent Mailhol


