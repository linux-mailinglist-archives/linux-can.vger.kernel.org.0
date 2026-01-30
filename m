Return-Path: <linux-can+bounces-6418-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOncOQiZfGmJNwIAu9opvQ
	(envelope-from <linux-can+bounces-6418-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 30 Jan 2026 12:42:00 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0ABBA25B
	for <lists+linux-can@lfdr.de>; Fri, 30 Jan 2026 12:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03D7D3011BF2
	for <lists+linux-can@lfdr.de>; Fri, 30 Jan 2026 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675472D3733;
	Fri, 30 Jan 2026 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNGVY6gR"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241BC36C596
	for <linux-can@vger.kernel.org>; Fri, 30 Jan 2026 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769773318; cv=none; b=Qy9E4JYWVm9ig0RYXKY753btQnmtvlvtEqP0gHGdJa5UyAnNTO/BPUMnbIOLpNe6RsHf4PDLpIjg9yFbH1o26Mt0xKImiP564Lvvr3iq3A/is+tuxAiazcxwaK8DExQdkiCMROnVCjNKI3AJdRshqPFcJHrgNvVgDoDaFqFxQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769773318; c=relaxed/simple;
	bh=QYbm57pbO7UP72Nd6eTkTa1GxsZUUno9GSyI0kkRqQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ah9uv0bWMeMeoE8F0l9XmLqltoj+Rk28oOznEEIxaj+T89QQpnScIT7I5KsWQy96pjJocL1cN/1Hs5d+KqYqGbcHY+raeSa7gUx0PpMomhMujca2w+2GW/POQ/u2xnvmKZ/sUQgB1WqG27KU1ukTSUYq9xhLv3NOo9F2K5V2tqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNGVY6gR; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4043497eec.0
        for <linux-can@vger.kernel.org>; Fri, 30 Jan 2026 03:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769773316; x=1770378116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xecIX2fMDAwRib/lst+YsPeYlfC8fIbaBNXW8TdPxjw=;
        b=aNGVY6gREu1bjNZinnmBxXxEs/J5h9aZ4e9gqVKA5/bvlAmD9oJj5H32iZdPe7IMG1
         ZfNO30iL3Bl7Emeklueo7SHWZwOjNRURc6ZPOiRq19OjVsD0tChQ7gZGolwWQv88+dmj
         Ms2zl2MDwdQct68JiyyDHGfFRllXEj7g8HLj75eQ0dfCwRBreAQfc4KQHELrHjqXfLqd
         fwFMebQ0M9GAKwHkCdSVhmpW7+9CdsCsawABpBtI5QIXoqx19FgHQa57uvusLq/8SIn3
         422iIbGG2tcvEuTmFUXuUC9eE4HthA5J7cU2nO3uPOGJIk9X34Qs4lNLwfy2LU4JW2kh
         XgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769773316; x=1770378116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xecIX2fMDAwRib/lst+YsPeYlfC8fIbaBNXW8TdPxjw=;
        b=niK9SbH2YoYgA1Nh7jB5pPQnMEbzvydIwCtXgGANFSHv2h8fICJjjUinFZNCalPFiy
         /Y7PHMzuMkW2aDl0htgpf9ALr1uo8osMsgq3BUrZtm+AqdKb6wJTaaFcyljo7uH5qNh8
         nu0zaC1LcRrbWgvVPi479JfN7UPTRiA7UK7ZXa95cPijWV4g+d7JDkEDCWnGUi5bxlVa
         gYoW/gBm4ybyFdkxwip5i5lZ4fuJqL3/NwfzlNWJC0YmYnAwCcl/GqgVOZdCHF2eEXlN
         aaJIwFLRUcUvXCD7m/v/Rp3kKGY8kK3vGfKAm6EPYUW6bQYaLx593vPtNZJqKM9z3K7X
         2TQw==
X-Forwarded-Encrypted: i=1; AJvYcCU3HuBp0jk07TJ9y02K/q64mTKHVs5+TiylR1nVRqG5fM5ATGh7CSIKIRVE5cPDDWZseCNLtchTyWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ38Euhh6PQivQeiSlTmTKzM1fsF9zQR7LKRwRGa5Ebe6SAJ4U
	+s0EVMlkPjieT/0Gcmehj+OIh1aXdYbpC5xv7zeA6Lll5+fvhZ6zqreU
X-Gm-Gg: AZuq6aKOmzbbrXXZGekGTXpwO9aGp2qadoVNAlA4Nf4n8EGdSEmK0dOiJcCSplHKvZT
	2BwTpYehK1kQgH/QiAQ3J1uyjdgjSlgB5Pfl/Rg+6tTfzs9jq5jRsje5pxnh/BFKE4Mcla74eM4
	7YeeOa/g9Nl1iABohkwZtYAgq+C8FzwnyspyayQZcpSc7GjKcZAJmqmC6LRO1n2ey+s9LtpbkXP
	Ur0Xj7S727MuqH6P0699yexziq+hsrC1HCepYPlL4xazJ9G6Vi/sj5VPqCVAjss1kNV0T474oSl
	nx0P+aZclpG1CQogwua2SmoqgP3ebaCO9iJhR+3sutGvzBYrGnQ3JDLrE4q/Hu8VS2dTFpDh10X
	fMCb8wcpL2bSAiCe9GqqvGT2WJT9ZDK9LDhHXbuZNI0Fa4ZiKoi1BPkyJ3CWg+FMr/KIIpeX4Vj
	s27+ojYydAvgeybqmmLebRmH9vQJdmrmMazyR7YYhG9DMoMfCmiv7s0UxCC7i9pkbryBfrzkW9o
	NCbqEt3M90G0dBvayj+cIBOlvkrRR+sGLNl6sAQbn7RAnhG4ymILrAYe6lxn68KG5CpDJYjMqZW
	B6wY
X-Received: by 2002:a05:7300:3249:b0:2ab:8ef5:df2 with SMTP id 5a478bee46e88-2b7c891b404mr1101106eec.35.1769773314519;
        Fri, 30 Jan 2026 03:41:54 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7bb9ca10csm5424424eec.30.2026.01.30.03.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 03:41:54 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH net-next] net: can: ctucanfd: remove useless copy of PCI_DEVICE_DATA macro
Date: Fri, 30 Jan 2026 03:41:33 -0800
Message-ID: <20260130114134.47421-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,cmp.felk.cvut.cz,pengutronix.de,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6418-lists,linux-can=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B0ABBA25B
X-Rspamd-Action: no action

The ctucanfd driver has its own copy of the PCI_DEVICE_DATA macro. I
assume this was done to support older kernel versions where it didn't
exist, but that is irrelevant once the driver is in the mainline
kernel. Remove it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/can/ctucanfd/ctucanfd_pci.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_pci.c b/drivers/net/can/ctucanfd/ctucanfd_pci.c
index 9da09e7dd63a..35edac9c0a5c 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_pci.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_pci.c
@@ -22,14 +22,6 @@
 
 #include "ctucanfd.h"
 
-#ifndef PCI_DEVICE_DATA
-#define PCI_DEVICE_DATA(vend, dev, data) \
-.vendor = PCI_VENDOR_ID_##vend, \
-.device = PCI_DEVICE_ID_##vend##_##dev, \
-.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0, \
-.driver_data = (kernel_ulong_t)(data)
-#endif
-
 #ifndef PCI_VENDOR_ID_TEDIA
 #define PCI_VENDOR_ID_TEDIA 0x1760
 #endif
-- 
2.43.0


