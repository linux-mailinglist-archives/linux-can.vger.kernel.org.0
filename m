Return-Path: <linux-can+bounces-4543-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19439B4A25C
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 08:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6E91B25CC8
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 06:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0717A301480;
	Tue,  9 Sep 2025 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2mWtWe/"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4921FF3F;
	Tue,  9 Sep 2025 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399804; cv=none; b=W5er9cEmT+Y0FyoRBKFrVCq4JlMuv+sbUlDUl2yXfTRP2qYiqcriYXVULK1T7EWOZDjJCLnrFasRnXLqidAM76ubcMxmJDgYhZhaQROiW155R23HWrlKGCrvX/zeJxZsfbB0tr9uO6mc3MSERW+m+wpfxF8G2HEF5Rm8UsTotyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399804; c=relaxed/simple;
	bh=wvvnttkV/VQrxMem/X3WhG2eHCcE+0U+1oEqSRmI1YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dk3XQ1JM8oel7eTf/ioKujdCR45Y79v31Lf4nVbOouoLwaMs69/raswGQKQCpj135BAebSgfVsJEVnuYKU8rNF4EvgYEApfdghHWVf0ix+AeWJxAwN5U+cLKJfk07Q3EKarQzn5POyn/rT+HVAayhWNvyYSnQ8mL2xC8N//MJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2mWtWe/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC54AC4CEF4;
	Tue,  9 Sep 2025 06:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757399804;
	bh=wvvnttkV/VQrxMem/X3WhG2eHCcE+0U+1oEqSRmI1YY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o2mWtWe/jKZ/oKscWqwW+q6Zu8RDB33ri3RMra9rvUGy6jRdk8X3KKekPEA0/Nj8f
	 WIROz8GL3Q5mldWmYVZwCJTvrCVgNvpimHWvO+JFiqzd8ueNV7hVnJyrcCjMVsjXI2
	 k6Z9Ymag/uuVKr/XcVDjr2mYPDk8D1zgyQaSpgAamyBFGXQP4IjAEa71doQFJu5YH8
	 cfFZJ3gMYAz1SHDOow25q5oyGWYXZjtdgUD8ENSUPiFN7/5AkQmW3KpPGL2+UXPtL0
	 J5WLLDsyrt4pMdkGbThshqV0Gw8nSYwKJPWTnwpPm2HE3pUosPVJV5Hxi/kxJObaMW
	 DWpc57eBeBOSg==
Message-ID: <270d01d8-63a9-4e85-8193-51304e8f23cc@kernel.org>
Date: Tue, 9 Sep 2025 15:36:42 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] can: rcar_canfd: Invert reset assert order
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1755855779.git.geert+renesas@glider.be>
 <f48b37ece8058e0d94d79bfd9188fef046114c06.1755855779.git.geert+renesas@glider.be>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <f48b37ece8058e0d94d79bfd9188fef046114c06.1755855779.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/08/2025 at 18:50, Geert Uytterhoeven wrote:
> The two resets are asserted during cleanup in the same order as they
> were deasserted during probe.  Invert the order to restore symmetry.

Question: is this only a cosmetic change or does it fix any problem?

If this fixes an issue, please add the proper Fixes: tag.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>

(if the Fixes tag is needed, your are still welcome to add my Reviewed-by in the
v2).


Yours sincerely,
Vincent Mailhol


