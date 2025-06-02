Return-Path: <linux-can+bounces-3757-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A13A1ACAF50
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 15:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E201BA1B82
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86C61EA65;
	Mon,  2 Jun 2025 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="K+wmS/QR"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-74.smtpout.orange.fr [193.252.22.74])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E42C326C;
	Mon,  2 Jun 2025 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871920; cv=none; b=NhU7dgAjHbdxuaVOVb0Ns7Xyv1O0w1/hMY5bjb/Qb6F9sffC/d9mFYcMyLKC95nDz0ZazkhmNdqESw04Xlgy4SvRvoLGmm25Pw5L8R5LmDVre1v/++t+6PXdNfQx9rTcSr/tiAJ7bMSrMhXM8SeBdjqJg1uZyIxOVzqKvDb2emw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871920; c=relaxed/simple;
	bh=C1TL+0jfEA3Ble3ZW3TJ5e9e90kW3ZjkXhf1dFC05EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYvbIYOfj8MFnoV7zf43iz4Vrd7XiQM8YcOyfDwNZ5cfZtNVQ0Fxo9zLKqvVDbOPDQGrRNZOVD2DU1aStqsS//7Hmssh1reyRaFulkEyVp1u3iSM239tRABhC1MA6lcmu60emgCW0wWolz6vrQw/LT6IRWgmtkMJ+4N5nRrtRHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=K+wmS/QR; arc=none smtp.client-ip=193.252.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id M5SKu8rl2411zM5SKuN4bQ; Mon, 02 Jun 2025 15:44:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748871844;
	bh=d+VgD5ALIgLT27ruUsd8aqCzcm65bapheM4Yr+CdinQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=K+wmS/QRFUo8/K2eEuJwWcJynoks+biyaYV75uzY2rbPGFTIH/yYEO3NYLiBqqg03
	 WOEhXKb/SUOS5kKc357vCBZDUKLWdntWVuyw7mhKTgPOe2hnuOdsDuShzQRH3SYvLx
	 sqKGe1q3gO2ADEbm1uwvRtdrpS47AexExum6dDOOFy5LXZaTT3KtkaCsLmTys2FYJO
	 6cnpMrpOR19FAg8Mf8lG660xWDLZzSim5ShRtyyGonlLEsmwZ3T7ysid442DJQiH2t
	 qjcuElprC96YijzTNdeyAmPsgeLiAAQ05T/O7+91qGAFzpUVVqySKc6oXZWBTgzjcx
	 CG7wXqzvPvTfw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 02 Jun 2025 15:44:04 +0200
X-ME-IP: 124.33.176.97
Message-ID: <2bb4c0bf-4b65-437d-ac18-93b1c1fc6fd7@wanadoo.fr>
Date: Mon, 2 Jun 2025 22:43:59 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] can: rcar_canfd: Add support for Transceiver Delay
 Compensation
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Biju Das
 <biju.das.jz@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <cover.1748863848.git.geert+renesas@glider.be>
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
In-Reply-To: <cover.1748863848.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/06/2025 at 20:54, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series adds CAN-FD Transceiver Delay Compensation support to
> the R-Car CAN-FD driver, after the customary cleanups and refactorings.
> 
> This has been tested on R-Car V4H (White Hawk), V4M (Gray Hawk Single),
> and E3 (Ebisu-4D[1]), using various data bit rates.  Without proper TDC
> configuration, transmitting at 8 Mbps makes the CAN-FD controller enter
> BUS-OFF state.  The TDCV value as measured by the CAN-FD controller is 4
> on all boards tested (base clock 40 MHz, i.e. 25 ns period), and ca. 90
> ns as measured by a logic analyzer on Gray Hawk Single.
> 
> Note that the BSP (predating upstream TDC support), uses a much simpler
> method: for transfer rates >= 5 Mbps on R-Car Gen4, it enables TDC with
> a hardcoded (hardware) TDCO value of 2 (i.e. actual 3), which matches
> the behavior of this series at 8 Mbps.
> 
> Thanks for your comments!

Aside from my request to change the function like macros into actual functions,
the series looks good.

Under the condition that you rework the macros into functions:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


