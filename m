Return-Path: <linux-can+bounces-1116-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DEA948191
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 20:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E19B28DF22
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 18:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC2C15B10C;
	Mon,  5 Aug 2024 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="10vt2jvm"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B02AD13
	for <linux-can@vger.kernel.org>; Mon,  5 Aug 2024 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882671; cv=none; b=J1F1EQkkQ17kqwiPai8nwiDG21B1qLjTiMNBSuEplcNd09l9fFdI/mjAY0noWxYF4DYv2PnKpsB1rEWBENbJkFLg6A262ScH2rxiS8tx5105L+xHmBb7tgioB3k3ImbX72aJqeAYsJDFUsi4UR+Enq5uvZl7k169UuXW6lKTxV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882671; c=relaxed/simple;
	bh=DhthJzQUgrAFURwHIvJzMMhEyam9emx1mKZe4wt+dcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tcS++kEyFN3tnqkYJIO4GKQ2p9vtsKg5ubsAn7dTN8id2mDNgrkEtacAuoi+6X7KMsdGgTLzhh6tnn+86gfmwu5RJGcZdHwwyUniK4mSA8mv4i09etO6g5bcVxHrwqpvudMHBlMyHcxztZVeJYG88oY0TxKTZpPWZ0n8e/ky28M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=10vt2jvm; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-397052a7b63so44120875ab.1
        for <linux-can@vger.kernel.org>; Mon, 05 Aug 2024 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722882668; x=1723487468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBokw9oEyYRijU8V8MR0ptQT6J/uWSsuZHdUP+pag0s=;
        b=10vt2jvmG+++8/EYrdLZPJv6mcId3n3HqEf83gNpZGTj7UIWjiJbbCM7opLJX6NUn+
         Y1l0h1VcmUiamru8/YN5xR8T2bawZplfHPmUWg4bdtYfMSFnYsfk4m2vKj/47fwcezYs
         b7HjX4GD+jvDw+OObqLwjqCWUmcLkS+Y7TcSOvSA55i3lIJiF7BfW4SGRJOe1Y2CDawn
         8xYafdMWh6m3hTerAoC0qIgnzGPqLd6tlUJdmNtOAqwYwBKs8zYGhY98/l2ijP28ZVhX
         nZITxuwc1aCq8ByErcxoyFpb5sOeejtI5FATaNEgg3Vjhowxiy7Xc7PolEE8bCtD4S4s
         vhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882668; x=1723487468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBokw9oEyYRijU8V8MR0ptQT6J/uWSsuZHdUP+pag0s=;
        b=cHhFXf5RhZVEoyw+OYPb6E6B6RIjBaaI6QDzsGNymgdO2LAk3YjV3QeGpA7MulKwRU
         cTksKhOlgGI1lifeiPF8+ecI2CXZytS15zwfxXzdPpJ7N+zQRnzlk2rftEKImwfGuAoB
         xA8hseIb+ZpLWSAWp68RQSoK4SQ4sR9I2z4Rq6cYYXSTwjEYHu/nnURjc3q3Y4wdoTRq
         I6psxFESeK/N7voCxEXOSLR79jtbB0Uw6Z2w93po9LPZof/7+i/+VIG9FrwTJFKoSKua
         Nm1AQrRRwPWgkhOX49TATLv8B3qSigdJWGtT1Z0X3rnl/97mMZkJ7uKfJXppx1c09+z+
         qToQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMZekaOzr75I9QJ6QrG/RPx+kVYlNDB0nqg7xfH3ehJIEr7kA4mdgUrVhM2g54zxAmDSUQ4MSyxZK92zOGb7xwTdxJvmHcZOMK
X-Gm-Message-State: AOJu0YxihIZYkB8D9buT165BhGBp/tn2c9Fsvh6GQCmbgbxwg8PcHKJU
	ArqilLWubvk218JDdhCwXWH1JMwbf+cBj02JBLDJKWKc0QNl2b9Ar1LJQm+DrdQ=
X-Google-Smtp-Source: AGHT+IEIYrl4tOpKOuu8cQDxHO7vGrhEGCxzt6s8+OkqVq51qI0Ood3dvQh4rwOjJ4Z2X9zNbWivyA==
X-Received: by 2002:a05:6e02:1ca7:b0:397:d503:6216 with SMTP id e9e14a558f8ab-39b1fc33e2amr181609425ab.25.1722882668428;
        Mon, 05 Aug 2024 11:31:08 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20a9af29sm30867925ab.13.2024.08.05.11.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:31:08 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Simon Horman <horms@kernel.org>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Linux regression tracking <regressions@leemhuis.info>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] can: m_can: Fix polling and other issues
Date: Mon,  5 Aug 2024 20:30:40 +0200
Message-ID: <20240805183047.305630-1-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi everyone,

these are a number of fixes for m_can that fix polling mode and some
other issues that I saw while working on the code.

Any testing and review is appreciated.

Base
----
v6.11-rc1

Changes in v2
-------------
 - Fixed one multiline comment
 - Rebased to v6.11-rc1

Previous versions
-----------------
 v1: https://lore.kernel.org/lkml/20240726195944.2414812-1-msp@baylibre.com/

Best,
Markus

Markus Schneider-Pargmann (7):
  can: m_can: Reset coalescing during suspend/resume
  can: m_can: Remove coalesing disable in isr during suspend
  can: m_can: Remove m_can_rx_peripheral indirection
  can: m_can: Do not cancel timer from within timer
  can: m_can: disable_all_interrupts, not clear active_interrupts
  can: m_can: Reset cached active_interrupts on start
  can: m_can: Limit coalescing to peripheral instances

 drivers/net/can/m_can/m_can.c | 111 ++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 45 deletions(-)

-- 
2.45.2


