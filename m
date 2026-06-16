Return-Path: <linux-can+bounces-7873-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D/b5A3KkMmpz3AUAu9opvQ
	(envelope-from <linux-can+bounces-7873-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2026 15:43:14 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D0E69A367
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2026 15:43:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=d4F9EuMb;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7873-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7873-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 062C4316D667
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2026 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3794443D4ED;
	Wed, 17 Jun 2026 13:38:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BFE40BCB6;
	Wed, 17 Jun 2026 13:38:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703533; cv=none; b=X3pHlE9PhHEeUJNsUHks9yIuGhYplFymjD4RGotE4j2ZFm38INGHhfnA+owT7dZUpd7XSjcEtPsXLDer1W5U/0GjCbsEcq0UZQyCcFy52ebXKHo+9wERaipZMfmJxHjt2+pfOUVOtXKt68tRFHI4W0Cj8gDe1CPqSNgd8kB5j84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703533; c=relaxed/simple;
	bh=R7Bf4XwxXcBmoaEbPhDRg6MQURq+Gk+znSviWBXEyQw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NnA7H1NyKjvaba2wCZXAaJQNz4AmfTfRqBe//MPawLNEhKIBZCZFqoeyz2HKPQXWGA6Mg76jboV1EadDRM3x8Y21G4z/lqoKXFXOEYoOYJh0I1RXW9q2lQfJB2JshvBHLhgQXvZUB0237HY56aN3fsGeVI/cw+HMmNRSX27C1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4F9EuMb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C36C1F000E9;
	Wed, 17 Jun 2026 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781703531;
	bh=6Mni33sR6cHey5x/QsVXQJR7xUylFERVrUN1i7Rxnlk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=d4F9EuMbrV/i2sSK9xruPZf2fv91FBo+13vupEFiOdzgkCLngt+zveNQtyNW2Xy/f
	 Idt2z5pqd+UpKznJJgANkebVyPdf/DJKtQ8ob0uMa4w8alHi0byu/JkekaNgiMojb/
	 ndiP51tpZrWMPdz3ZELHHWH/sU02Fh0Vq7Pf4AsZZnCRCM+kVkkJBk6nwNVbZHnCZQ
	 jXDHiiDKfB5dINdxAHpBKKRU86Md6avppLLBJ0VuBTuz0hdEiNMOTSA457iBivZm1a
	 Fmw/axUBoUQga0/DqtOQL7MpbMDwslPl2IGnpArHrdyu6qva4K6gQd3DEzGWCjmgWj
	 OM2h2VsPz72rA==
From: Mark Brown <broonie@kernel.org>
To: sashiko-bot@kernel.org, mkl@pengutronix.de, 
 guoqi0226 <guoqi0226@163.com>
Cc: linux-can@vger.kernel.org, mailhol@kernel.org, o.rempel@pengutronix.de, 
 sashiko-reviews@lists.linux.dev, socketcan@hartkopp.net, 
 linux-spi@vger.kernel.org
In-Reply-To: <20260616103018.105612-1-guoqi0226@163.com>
References: <20260616103018.105612-1-guoqi0226@163.com>
Subject: Re: (subset) [PATCH v4 0/2] can: mcp251xfd: Add ACPI device ID
 table for MCP251XFD
Message-Id: <178160960261.55685.12204073262177758524.b4-ty@b4>
Date: Tue, 16 Jun 2026 12:33:22 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=broonie@kernel.org;
 h=from:subject:message-id; bh=R7Bf4XwxXcBmoaEbPhDRg6MQURq+Gk+znSviWBXEyQw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqMqNojnRhzxjoez7sJ17/WcSoAw7IeDPvoQS4P
 N7+hgrD4UqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCajKjaAAKCRAk1otyXVSH
 0ACHB/47jaoMxZ3OmOPDU34TqWyD/r1iVbq6ZZQPi9fHJpRoZkyweLi5DYfiGPxNYsdub9jUBTb
 K6fRkifC0Jr/l6WOjjynDkkifvk/nfAXv2d1B+MwaL3oYC53jAQWyYi8M8A4oh+1koFyy9IfoIh
 AmfY1yGFRcm01xSn8XwaP43NgcvrkdTIGI1YSwn7SrOhtDCH/WKDf3kIuCn+4onSEBATGH0UTUY
 fbqTdi9dXfKW0VdW1lRCe5qTxD3Qkf1wao+UT3YybjCFCRb/mxhT1ZKl8bY3/XVmjJSTFvfI0co
 Y1vB9QJWjH1fkKQ8igbizYnoKVJ6W1OElj/oVDTfoz8QCnmJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[26];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-bot@kernel.org,m:mkl@pengutronix.de,m:guoqi0226@163.com,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:sashiko-reviews@lists.linux.dev,m:socketcan@hartkopp.net,m:linux-spi@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,163.com];
	FORGED_SENDER(0.00)[broonie@kernel.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7873-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1D0E69A367

On Tue, 16 Jun 2026 18:30:16 +0800, guoqi0226 wrote:
> can: mcp251xfd: Add ACPI device ID table for MCP251XFD
> 
> hanges in v4:
> - Split into two separate patches:
>   1. SPI core: add internal NULL guard for spi_get_device_match_data()
>   2. mcp251xfd driver: cache and validate match data pointer in probe
> - Remove duplicate spi_get_device_match_data() invocation and unsafe dereference
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[2/2] spi: Add NULL check for spi_get_device_id() in spi_get_device_match_data()
      https://git.kernel.org/broonie/spi/c/0f82535b5537

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


