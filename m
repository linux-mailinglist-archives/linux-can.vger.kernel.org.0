Return-Path: <linux-can+bounces-7696-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLGhBs9GFGrzLwcAu9opvQ
	(envelope-from <linux-can+bounces-7696-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 14:55:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 856825CAC90
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 14:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D65D93032048
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 12:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7B2382F2D;
	Mon, 25 May 2026 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGrAti9Y"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27672381AE6;
	Mon, 25 May 2026 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713627; cv=none; b=af0BDNcSF360r+1F/fy9KWz5fIX08yag5dHH1Ph5rJR9/J5wJRL6pgWoFQB2pIdBwkuDBqTJg+/p2DRrzxA3clKAOvMwv7sm7qSRUJSYbLKiap9c6ZFtU9l858iM1iUnYU6hJy6CYPFKmEWPTVoK6j8vizGSuhBRPD5xL+LagYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713627; c=relaxed/simple;
	bh=DIZwqP41tyEe/8hPVsegjZc07Fhyc7NMZvMgei5ETQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jv0Ud+8fLXxlr4LQ1Yk3hCJyAW3y50/F9yP+TXgWakvWAGDe3sa1l5eCkIRkys6ozgqKLkSgD0WpuOibgUlrXwKbt+GI3ZEn53TGCQ/dFz5eu2EcGAouD++3iZoSA+bPimdHf5fGAqBe6DiCZ32KWo4/TcamGtbwpQB7r4e7xyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGrAti9Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4951F000E9;
	Mon, 25 May 2026 12:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779713625;
	bh=OQkCyN8EOO+Sh6b4vpdhJ/1vAaeseyuR9ZKMPwZ4Emw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DGrAti9Y+63+kP6YvwChZ2SpvYGUI3uCrNj2mEQ08L6S2zGe/X18d0AZ1kpbxHSfy
	 45kgJl3Mzk1CGuvtmxrpAx4uF//A/Xqznydxe4KV1BnGdDe4ysAzmt12BKeb72pf4Z
	 2p6fejyKuMmdS1c+BYXRgKleUd7x1BfpMcS0FNI7DILbXmN1um3BHD01LRxRoKLNRK
	 OPf1ZiZ79aSpLOLiA3ONZXkWip0IeEDdD1OhrC1jtKseK8UcMIM2mBEGtQtVVqY+uJ
	 r0bm3SQgYWFrS0f+IsuXER+rGM4wv00t0guaPbJ8h5AUKSg/dAqPqaZ+YtrWmv2Rq7
	 blZFIamOBKEhQ==
Message-ID: <150cf471-665a-4693-a2d2-31c73cfa8e57@kernel.org>
Date: Mon, 25 May 2026 14:53:41 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: m_can: pci: Remove driver_data
To: "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20260515-topic-mcan-pci-driverdata-v7-1-v2-1-e33e014ff328@baylibre.com>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20260515-topic-mcan-pci-driverdata-v7-1-v2-1-e33e014ff328@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7696-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,baylibre.com:email]
X-Rspamd-Queue-Id: 856825CAC90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 15/05/2026 at 15:15, Markus Schneider-Pargmann (The Capable Hub) wrote:
> driver_data is set to M_CAN_CLOCK_FREQ_EHL for all models. This change
> was already five years ago, I don't expect any follow up models that
> need to set a different frequency through the driver_data at this point.
> 
> Hardcode the M_CAN_CLOCK_FREQ_EHL. Once there are new models we can
> evaluate what data needs to be in driver_data.
> 
> Acked-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann (The Capable Hub) <msp@baylibre.com>

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol


