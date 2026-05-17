Return-Path: <linux-can+bounces-7647-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDAiOU36CWpPvwQAu9opvQ
	(envelope-from <linux-can+bounces-7647-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 19:26:37 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBB256284C
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 19:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7677C300D6A6
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6723C4B63;
	Sun, 17 May 2026 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7W4X1Qe"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76383BE645;
	Sun, 17 May 2026 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779038785; cv=none; b=odaaZfbweVCdFCN7uUHon1yUtDyCFOi4Hn8QpTGeP6FZ+Is6ESFbgQPKxwdnY8iWNLZcaXi9/3VZMTA0EFDk+Yt5wktMAZbMmGKPQ1qJILUXUA+YVRwlYLhwvJ4u9rSZbwcPgnEKVFYZviAqnrznRcXlz4MEjAB0EaLzbJxDerk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779038785; c=relaxed/simple;
	bh=HIHlJVY+X/4zYUaiWh6XBt5tiLGu6dLW0o8MzgbGmBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8YpBGf6JtuLvH5NLOsx0mpCeld8FA1maji0Bm1Bd1niSJNlEEFem1MgSkGxdeqkiyViL5ottQEK3KkAz4xBzvd5tIw6R8fJc/TNlSNtKGMX1DjLADj9IgTF2EiiiSlG7GTzWrY8Ut9V5tJAZOj17YcJzf5PfbGKHMdguGGl7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7W4X1Qe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018B0C2BCB0;
	Sun, 17 May 2026 17:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779038785;
	bh=HIHlJVY+X/4zYUaiWh6XBt5tiLGu6dLW0o8MzgbGmBM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p7W4X1QeCLlOrnNrSAjbPbsPx0GhpcleYJ/uoVC02U7BlwYVB7eyKduo6DGk+fH+l
	 tnj0Bn37t5JAMWqmYRl14/trjz+ykibsz+kyQ2petauXXTa1CVLZdmf2o0ANvBm/dC
	 /50Vnubnrfp4b8KCFEYPTgYvPmlB1URSOYTp3kE/Jr4ouP6flNx54uBkxTzdvhkbV4
	 ENbES8NjSWQMiVuLHflJ+O3cyvojYMC2QSneCnSFXyT1GoLT8IOY303okFhCvVbZcb
	 mTF50ApIJxEM2FuL+G1gIzXNQgI3+8yE2HC759UlNms8+uh/ErAa5FW1g6b1174QOH
	 4a54NdF/udUEA==
Message-ID: <b978603c-4878-4eee-adc1-290e905fe768@kernel.org>
Date: Sun, 17 May 2026 19:26:21 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] can: peak_usb: validate URB length in
 pcan_usb_fd_decode_buf()
To: Berkant Koc <me@berkoc.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Stephane Grosjean <stephane.grosjean@hms-networks.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20260517-can-usb-fix-cover@berkoc.com>
 <20260517-can-usb-fix-1@berkoc.com>
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
In-Reply-To: <20260517-can-usb-fix-1@berkoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6CBB256284C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-7647-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.905];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 17/05/2026 at 15:55, Berkant Koc wrote:
> pcan_usb_fd_decode_buf() walks records inside the bulk-in URB by reading
> the 12-byte struct pucan_msg header from the front of each record. The
> existing loop only verifies that msg_ptr is below msg_end before
> dereferencing rx_msg->size and rx_msg->type, which means a short URB
> that contains between 1 and 11 bytes of payload causes a two-byte
> out-of-bounds read of the rx_msg->size and rx_msg->type fields. The
> fragment check that follows compares the announced size against msg_end
> but lands after the header has already been read.
> 
> A malicious USB device that pretends to be a PEAK-System PCAN-USB-FD
> adapter (USB IDs 0c72:0012, 0c72:0014, 0c72:0016) can keep returning
> short bulk-in URBs and trigger this read on every poll cycle, leaking
> adjacent slab content via the dispatched decode paths or simply
> producing a KASAN slab-out-of-bounds report.
> 
> Apply the pattern from commit 6fe9f3279f7d ("can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing header"):
> require that at least sizeof(struct pucan_msg) bytes remain before each
> iteration, and reject records whose announced size is smaller than the
> header itself.
> 
> Identified by static analysis.

Could you name which tool you used? Otherwise, this sentence adds little
value to the report.

> No KASAN trip available without specific PEAK CAN-FD hardware.
> 
> Fixes: 0a25e1f4f185 ("can: peak_usb: add support for PEAK new CANFD USB adapters")
> Cc: stable@vger.kernel.org # 4.0+
> Signed-off-by: Berkant Koc <me@berkoc.com>

The code itself is OK. Not withstanding of above comment:

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol


