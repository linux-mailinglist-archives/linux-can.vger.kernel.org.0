Return-Path: <linux-can+bounces-3822-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7635BAD669C
	for <lists+linux-can@lfdr.de>; Thu, 12 Jun 2025 06:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189373A26CE
	for <lists+linux-can@lfdr.de>; Thu, 12 Jun 2025 04:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D671DED60;
	Thu, 12 Jun 2025 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="YrmyfNcu"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515A51DAC95;
	Thu, 12 Jun 2025 04:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749701057; cv=none; b=tFINAvJVfJIPQVSktfoMAL2BDR6nkykU+/TOOKhkLCs+bPipmNs/vtFSuu19ts+hQdW4PgbYoZOm71rJoEF67Vtl2Cu6MtphWz3x6KH5rVqYMipQXxhgwKL5gYjw5Dc6Bs9Lubxu+JK5fRjdyDCStr2tM6OXNGfeEyPDkW3Zk+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749701057; c=relaxed/simple;
	bh=L6Iu2gOcIxnTlPrhTq18q2TS44blsV/Oxstv1Vv/QMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIiAzlMw2717vcpHjps8nFZPpoqeIA21aBqlKuW6gyGwbfwwXpVfhfJeM3Y+/MMNo5cleGe2IvoWKRXTsYDHGNZXLg80y2uTot/8xIeb5r4mdZSUyfv5HJc6K+E9WOtA0Gv/D2OvZyPiWW1Sdcplvv068QcNBeBvNQHgZWPc9eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=YrmyfNcu; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id PZAeuUq9YA6zePZAeux752; Thu, 12 Jun 2025 06:04:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1749701051;
	bh=59/hSpwA26OzOgRn3n0jfYIF0gZSmqx/KjQnmetoJg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=YrmyfNcuuv1OEoUCoZc/5THIepQRR1lFAebqTTp8Z/qxkql1P1Y/EYjYRhEXGk1JS
	 GSw/tWM93oBiI5sFavsA/jVdYbRii89wxcins4g2bkDUMG5uIBXj9rmF6ZHk/PdlOo
	 FmdotRI5eosuk3Nr3ESoSdDg4TxhW4L7TJUROy85/LoGLFYCf6nPjnT585O0FMUB3H
	 vhjV+OedvOhtu277SgMCqqXyBC2yiqyvN7hUgWAgPPnN0GlmTT/ZRs1soYF3LGLTTK
	 ptgvgwDHtBBXMLTdPNZPEIAwjHGKnH9WK27Ca5Psc9TPlPqJL+aHwU98RTh2+5lu3Z
	 gT6LB9cEqa9WQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 12 Jun 2025 06:04:11 +0200
X-ME-IP: 124.33.176.97
Message-ID: <ec538faf-43f5-4245-8f67-920b803f1ff4@wanadoo.fr>
Date: Thu, 12 Jun 2025 13:04:07 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] can: rcar_canfd: Rename rcar_canfd_setrnc() to
 rcar_canfd_set_rnc()
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <cover.1749655315.git.geert+renesas@glider.be>
 <9fdc2584ce27b2784ecea76390d2a81eab289d0d.1749655315.git.geert+renesas@glider.be>
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
In-Reply-To: <9fdc2584ce27b2784ecea76390d2a81eab289d0d.1749655315.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/06/2025 at 00:37, Geert Uytterhoeven wrote:
> Insert an underscore in the function's name, for consistency with other
> getter and setter helper functions.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Yours sincerely,
Vincent Mailhol


