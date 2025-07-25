Return-Path: <linux-can+bounces-4117-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36D9B11712
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 05:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF82BAE2A54
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 03:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49607231845;
	Fri, 25 Jul 2025 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="cE5XeK5G"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA772E36F2;
	Fri, 25 Jul 2025 03:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753414177; cv=none; b=X5mBsTmq70eTDQ8NaEoRIqwOByquzTQTu57t0rvxr3k59Z7ZrjHt6VXBtlWHscK/W70UgJVIw+E2CjeTr7XuF1kSzH4U5VDhy9hG8abCqXZjsP/7XEXtqd4g1JhOYYLdvT2xOcAtW7gRzeAFKrLJ+2rImOkBx8CW6wVK2OP/cYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753414177; c=relaxed/simple;
	bh=9zxhTRXdrEdIPOvJY79pLHplYutW1EPSgTtwEVYpHyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RdJL/nB6ugvX8ItbK1OA9xTVXAqGkhJP9VUxPlBimgA/lX2mJLdi0d0NqTPAhUC2zrKvhVwJ9i8ouQoPREby0vs6Z8n/a5Q9YRzSLipFva8JvgmPbEXPK0ZlSFBcEWNYelGyaU9QOI+v3qX+DMt4pnxvMA81f2GYKBFXcslXpMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=cE5XeK5G; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id f97iuvTcO4EFhf97jufGL9; Fri, 25 Jul 2025 05:29:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753414173;
	bh=9zxhTRXdrEdIPOvJY79pLHplYutW1EPSgTtwEVYpHyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=cE5XeK5GZEXrkvjbUnxAOBsKjvNFI9HtiJUAoJW40vBiZruFQWJG1Z9a8AogxiIcl
	 oy/w/JXHnd2lYMtDizT37nwzNbQsQSZWtApJPLQefFiL8TRA7JdDIjYnranyI7RzyH
	 i0b7O5lCBL81ZTkSRgkt/1ziQyeEh6KfF0ch+LrDzU4KQ5gKc0RlnGI1do2vpix+Ts
	 D4Uhbilw4mqZ6+2nAZ0U5Rn/evGhG85Cshh0AUwP2tvgVHxbvk/JQYlLbf16KZscWE
	 Ew5rrXC2KtbR/R6Qlp3xJgfyFbrJMQbjCxp2R58ss6B9trDqrk1uZene/YXExllQUe
	 tM38oijO9j7ag==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 25 Jul 2025 05:29:33 +0200
X-ME-IP: 124.33.176.97
Message-ID: <aa90e02d-25d5-4f76-bd91-26795825c8a6@wanadoo.fr>
Date: Fri, 25 Jul 2025 12:29:29 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] can: kvaser_usb: Simplify identification of
 physical CAN interfaces
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
References: <20250724092505.8-1-extja@kvaser.com>
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
In-Reply-To: <20250724092505.8-1-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2025 at 18:24, Jimmy Assarsson wrote:
> This patch series simplifies the process of identifying which network
> interface (can0..canX) corresponds to which physical CAN channel on
> Kvaser USB based CAN interfaces.


Same as for the kvaser_pciefd, there is a tiny transient issue on a missing
header include. The rest is OK, so, for the full series:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


