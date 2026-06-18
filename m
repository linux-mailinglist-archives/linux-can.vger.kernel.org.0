Return-Path: <linux-can+bounces-7879-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l9goApX7M2qXKAYAu9opvQ
	(envelope-from <linux-can+bounces-7879-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 18 Jun 2026 16:07:17 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 843776A0CDB
	for <lists+linux-can@lfdr.de>; Thu, 18 Jun 2026 16:07:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=pt1Lllqf;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7879-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7879-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68E6B30D127F
	for <lists+linux-can@lfdr.de>; Thu, 18 Jun 2026 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15643FAE00;
	Thu, 18 Jun 2026 14:03:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB03B6346
	for <linux-can@vger.kernel.org>; Thu, 18 Jun 2026 14:03:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791391; cv=none; b=qR7kBmp3eHeZl3AYPuMyjlcZP9Py3vySM4KgIyfiy5oS5ACKp5voR99r4mhVAprFKc6ivPVxAXV23RaYV9ybMAvv4IlSuSpCRJxvkrYaANbV2FYbnfoyHyPNG7t3dAssJ64bJZ3BdBaCh2MfNdnLawDEyOaUFxO5unWCAmT9CwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791391; c=relaxed/simple;
	bh=263UnQqT7FgRjQmrIuWnRIN9Xzmjzy5Zozx+IEZgAgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kYAzX3fSmEmzh7f3uT1a0mZxoY1avMhiO68/U3pXm/A2hXoLTfFHbPqh5cC3E+FiDVhKNi032bPlziZslYXbX0jAEvWwTsBj0AHb+0+TYVbxn6hi4Vcl2OEOLyypK+HrODec+punSgGKwSqtum6nscFad7RUee9EaogFve5Flr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pt1Lllqf; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-462ebd5d37dso1167594f8f.1
        for <linux-can@vger.kernel.org>; Thu, 18 Jun 2026 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781791387; x=1782396187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jos76VU9rUcfTgCENKyUN1lsrrQ63yv55cXHCv1GV14=;
        b=pt1Lllqfz1DR5lS4hxUiGsQrthAzYZWCVFMOsUeERbgGrWTzXfKYxy0AIkSQzkhFAo
         H3Np4gA1A6ZHufF1UoiqaNQcs4usnBEC6d0fdBteYemOLjunU7q+qH3lnLAcM0MnsMrM
         nxqYTs18z+EHLx2380LEFg3XbH4cCC6hq3tmtgQm46KEJv5hBrAKuKjfKMNmcUh/Lb4V
         zIgZmCggCD6xisEF59/evzGLbzTuifT1HG81MOVxGcoSNIMR7BBtimzwZ1wnsG3z3itN
         FcKNNRjTK9wYB1pV496DHEqZ7FexcOWOSyny5GYeUUlr8uGrz7IvvsP+AqT9xz7XRpLx
         OHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781791387; x=1782396187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jos76VU9rUcfTgCENKyUN1lsrrQ63yv55cXHCv1GV14=;
        b=G3os4eg89zTkV0MScaxB4jpNZlRNfZLYsE0rAhUPP+d1LAPcwn/ktJQTW2ABzhFXmD
         RYo+7bALXpDAuXDsCZk2ZYOe4Vu/i+EjB/XmjXOynAO1tFiAy6QjYl5YNlX4qldFQfpD
         N8b7zjjIGMfLFDNGnO6CkaDFhbiAjs2NWhmJGO/CThUOZVlVlnLsDLxQMbhANmOP3Bql
         bKUPPj/0XYIYxEA6H3SV6Ep2zzHzujjKu3MjOwcKN7BNNr0aaebSNKKeavER1GtTWDmH
         Kk+dihkRQHGaXr6vbALS8bm1uciImakzpD1yG57sssiKgKLDdep3KmsFPuSpPyOd8An/
         vJCg==
X-Forwarded-Encrypted: i=1; AFNElJ+1PkJxlW8wv7sqTAuVY62T2g5e6EEKRR5albqmC1XBNdkDxnZQ9KJUGm9Vp00mjzzTZPKX4ZPHx+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/m9KfnnlV/0FcKIIReJnszXsAAIneOtm0S9GL4tDqR+DEqW6
	5JiNv8LnoLvYb3uzWziAmpdFqlw42AxGgRbWAR8YkaALDhygq0Q9EkoiX+aiAhDVcWE=
X-Gm-Gg: AfdE7cnOUzUaBw3PV0PfgysxnqAV4AOKCAfs2gsNmsAWrqWFpkLehz4gTNEymnZRcop
	D9ALppRCZCCUTWum1wws9diiLgP94CVfqjuTgBKP0C7fLQ0D6BRXWa44IkSZ1uaddkzhwkEJdBz
	kWpgqcGnOPqeAuMh21qHq2YmgNmcgAfYiHgDDRHyCbuNV3zyv9LNkvCPHG/PjstDgit6wmJpWeQ
	Iu/wAvPs4e97s4d37S8LOyAjJAHPcmwV47eV/B76KJtW33Gk8X2tEsKphIjhbbOJY31xffzUiny
	o9hi4zKtc32o2hQQ6rka0o6B2uzoqZtMzuY+zeyrO/WdbI4nSHa0c6qRe632r4I+Qcv4w7TZ+1h
	ynb9vTLMMLkGCVn7HxJYBOxNkbFWYGgjOEGWcbdxYMdZ5T3G/+roK7cDjlrAHWcP++oqhhU0i53
	DYYCCw9ddXKly8sFV3gfej+42U/vZqRBFJLDhS/vYyUSqsiD62II5k3yK/gpt3Npek7h6Z2X37a
	5Vq
X-Received: by 2002:a05:6000:4687:b0:464:6ee:4fe1 with SMTP id ffacd0b85a97d-46406ee51d8mr3568612f8f.33.1781791386660;
        Thu, 18 Jun 2026 07:03:06 -0700 (PDT)
Received: from localhost (p200300f65f47db04cea0a59ab11cac9f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:cea0:a59a:b11c:ac9f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46289c3b3a3sm15325402f8f.30.2026.06.18.07.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 07:03:05 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
Date: Thu, 18 Jun 2026 16:01:47 +0200
Message-ID: <20260618140147.142489-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2611; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=263UnQqT7FgRjQmrIuWnRIN9Xzmjzy5Zozx+IEZgAgM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqM/pML1hFap/UgihwRJNb3DQPM0zusq3sfUm27 yKUYXEx1neJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajP6TAAKCRCPgPtYfRL+ TqY2B/wPSLflQcf6bhsX8LkcflcqNm7174taCwQLa0R9I1TrLZQqw/AOowkuL/pwpTwGLrs84gR relE5J0uazE683Zv3i/JkOrMkiymyZUx5T5sOuunNvGrQhIRwJsk3fDxlfYrdQnPTf1O6wNk7TC Ev8kds36RmxGDCSzbhsYfvatVmoRtESYRP7bNPJ0j0xB9bmZpzM6Occ09QFN9eDgsYKsX2loH7d z30fZLMFcjkIVq2pglGw9xHrVAK695hDQ1TGxr1kbNzrgm6HVnxbgksjSI4m9H/hNSGOspTCKk/ IgD7zCruvvHll+ZJLNTAEsx2Xo+TASyfNvsOTuxJzxi0n0hl
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:jeanmichel.hautbois@yoseli.org,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-can@vger.kernel.org];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-7879-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,baylibre.com:dkim,baylibre.com:email,baylibre.com:mid,baylibre.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 843776A0CDB

When determining the device details was reworked in commit 5e6c3454b405
("net: can: Use device_get_match_data()") there was no replacement for
the previous handling of non-of instantiated devices via the device's
id_entry which then results in a NULL pointer exception. The only
in-tree provider of such a device is arch/m68k/coldfire/device.c.

Given the id_table only contains a single entry just hardcode the result
of `platform_get_device_id(pdev)->driver_data` and drop the unused
assignment to .driver_data from the table.

While touching the id table, drop the unusual comma after the terminator
entry.

Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
Cc: stable@vger.kernel.org
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this is essentially v2 of
https://lore.kernel.org/all/20260528094540.1867783-2-u.kleine-koenig@baylibre.com/,
but that patch was intended to be a cleanup, while the discussion then
revealed that there is a crash to be fixed.

Jean-Michel Hautbois confirmed (off-list) that Marc's and my suspicion
is true and probing the flexcan device provided by
arch/m68k/coldfire/device.c indeed crashes.

Best regards
Uwe

 drivers/net/can/flexcan/flexcan-core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..05b8ca72ca2a 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2077,10 +2077,9 @@ MODULE_DEVICE_TABLE(of, flexcan_of_match);
 static const struct platform_device_id flexcan_id_table[] = {
 	{
 		.name = "flexcan-mcf5441x",
-		.driver_data = (kernel_ulong_t)&fsl_mcf5441x_devtype_data,
 	}, {
 		/* sentinel */
-	},
+	}
 };
 MODULE_DEVICE_TABLE(platform, flexcan_id_table);
 
@@ -2148,6 +2147,15 @@ static int flexcan_probe(struct platform_device *pdev)
 		return PTR_ERR(regs);
 
 	devtype_data = device_get_match_data(&pdev->dev);
+	if (!devtype_data)
+		/*
+		 * If the device was instantiated via the traditional platform
+		 * mechanisms (i.e. not by device tree), device_get_match_data()
+		 * returns NULL. The only remaining such device is mcf_flexcan0
+		 * (defined in arch/m68k/coldfire/device.c). Pick the right
+		 * device type for that.
+		 */
+		devtype_data = &fsl_mcf5441x_devtype_data;
 
 	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
 	    !((devtype_data->quirks &

base-commit: e2cae00c05d196491c318196792297f2dfbaa02c
-- 
2.47.3


