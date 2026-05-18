Return-Path: <linux-can+bounces-7657-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBQcMmnlCmqJ9AQAu9opvQ
	(envelope-from <linux-can+bounces-7657-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 18 May 2026 12:09:45 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4522B56A663
	for <lists+linux-can@lfdr.de>; Mon, 18 May 2026 12:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC3FF3004243
	for <lists+linux-can@lfdr.de>; Mon, 18 May 2026 10:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB3031AAA8;
	Mon, 18 May 2026 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="q/JJrviT";
	dkim=temperror (0-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="efuWtV7H"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F3317163;
	Mon, 18 May 2026 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.95.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098980; cv=none; b=WWrdMb5SSGOADJckMwaQB06TzYiOoYi2hW1Hs+OwO/mx3ZwwBP6GjKKHiNNSldbtUqulCSx1R2i0J6oAbXxDKtcQ9Fx5nFJbOQ1KRgXwHqw3jPX4xfWEaLUnO3wguKlad4svaQzDspyrf9LZJImRNvPV2lJccHdRF7LIWSWyh+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098980; c=relaxed/simple;
	bh=xx5xGxZ0HbjQ/uTeoMm8qFIQ+IOXXdvxDFKs0PexdL4=;
	h=From:To:Cc:Subject:In-Reply-To:Message-ID:Date; b=urHq+lp3f7WllpdspdyXSHzE5macabqCOMj6lBCXmIqnft2D7//d4yHEkgRzhz9Gz2aYjWozfSRGqSf2SAtqyNJFTb6RZ2X+ZnmGPewRcw1WbCGLofTI8OB06E1X5aCa3MGaPmGJI8LrEsi/JyRRd+naWbkfw3DNh6ShyBawzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=q/JJrviT; dkim=temperror (0-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=efuWtV7H; arc=none smtp.client-ip=93.95.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Date:Message-ID:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qOZcHzFQs6+ZPH5VLzN8MPVqCvbGjRE9wSlF/Xi0stA=; b=q/JJrviTJsLTKAautR0kGBcNqR
	V3MGki5YSz+tQrjD49JC+nH5Kwxp+14K11uLC0j2DXtjB2HXJk2OPl+EIjMfKxAq8gTg0WKzciCj2
	yy9a0oaUwYcOdO/oRxyJbSFTdK9AxVlQg9TgS/6iF1zNhaCoUzJYtthDlyHT+OuC6H77atwnd5VaP
	NfwwriS+BFTxs3y7BYRMUWxOkuv/QqHfZ/ZbJz2287BFS24lNljlYThHA38cHPGd9CAzdQbcwKiWj
	QbNlwgOWYlznhvFnNIGUkfQqsaGum7N0NNGYaa4U8C9DskONtTMTioINIw1b9ma2OuX5Vn8pvLvw7
	N+o4MxkQ==;
Received: from localhost
	by mail-03.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wOuuc-002Owt-3A;
	Mon, 18 May 2026 10:09:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779098964; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=qOZcHzFQs6+ZPH5VLzN8MPVqCvbGjRE9wSlF/Xi0stA=;
 b=efuWtV7HAkQM3i/t2IWKoWSwn8mzRDJI3eLTatE8vkojfZI8sW5W/zwOdkwsLkEneYkb7
 OjpblLXvYmar1MbFC95yTvpddv+1cV7pHrDxLFakfkjoRh4RnGIaJSDvpC5fgliMwbLWVW9
 SON2+Ll8c8TYw1d9DPNsxwFbyxxOkbBk1mGhC9/3/ZcAubvd49vMVNuU0+xEb0YzLVh3bLp
 0mYYnRmexp1Eza1Clyadls1C/Q46aBs+GjkOrBzwTQAfOXTbI3Id/fn8LVnhKVNGNvPzglj
 zemNh6jTAEVPYXasrR9FbIaiUfjllgX5e2c2vh3d5l+MWSGnIHkM5OugWhRw==
From: Berkant Koc <me@berkoc.com>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] can: peak_usb: validate URB length in
 pcan_usb_fd_decode_buf()
In-Reply-To: <cd33f886-75fb-47b8-b839-97fc6b11743c@kernel.org>
Message-ID: <177909896433.60730.7315497633021818819@berkoc.com>
Date: Mon, 18 May 2026 12:09:24 +0200
X-Spam-Score: -0.2 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 4522B56A663
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.14 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:dkim];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[berkoc.com:s=me];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_MIXED(0.00)[];
	TAGGED_FROM(0.00)[bounces-7657-lists,linux-can=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[berkoc.com: no valid DMARC record];
	R_DKIM_REJECT(0.00)[berkoc.com:s=1984];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[me@berkoc.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[berkoc.com:-,berkoc.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,berkoc.com:mid,berkoc.com:dkim]
X-Rspamd-Action: no action

Vincent,

Thanks for the input on both points. Let me work through them and
share where I land.

> Your message doesn't follow the mailing list etiquette
> [...]
> kernel mailing lists exclusively require that all communication is
> sent as interleaved quoted replies.

For context: the previous message was a tool-disclosure reply you'd
requested via private CC, not a patch revision. I had treated those
two formats differently. Going forward, I'll keep both in interleaved-
quoted format on-list, as in this reply.

> Is this answer also AI generated? If yes, please don't directly copy
> paste AI answers to the mailing list. We expect you to add value to
> the AI generated output.

To set the record straight: the tool-description paragraph is template
text I maintain under version control for tool-disclosure requests
across multiple maintainer threads, not LLM output. The methodology
section (peak_usb seed commit, pattern scan across
drivers/net/can/usb/, manual reproduction with synthetic short URBs)
was hand-written from my notes at submission time.

Agreed that posting unaltered template text on-list reads the same as
LLM-paste from a reader's perspective. I'll rewrite tool-disclosure
sections in-thread from now on so the substance is fresh per maintainer.

> Ack. Please use that tag.

Confirmed. v2 of the peak_usb series will carry:

  Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline

in the trailer. Same convention going forward across all my
submissions, in line with the kernel AI-tooling policy.

Appreciate the feedback. I revert back to you with the v2 of the
peak_usb series and look forward to your review.

Best regards,
Berkant

