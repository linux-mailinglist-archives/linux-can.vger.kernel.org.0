Return-Path: <linux-can+bounces-714-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88330901472
	for <lists+linux-can@lfdr.de>; Sun,  9 Jun 2024 06:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B76B20CA7
	for <lists+linux-can@lfdr.de>; Sun,  9 Jun 2024 04:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCD1DDA1;
	Sun,  9 Jun 2024 04:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWtyydn/"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D24C98;
	Sun,  9 Jun 2024 04:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717908891; cv=none; b=VfnOMyfZYhcs0NZxxU2XU9r6fG7AvOs3kshhVUmTFERyau7lgCbu5N75PzPL3e2ZCGtKBcyw7JhPvUSW5UtRD6p8fUbAbPY1Xt6+npgrwPZc1oUpTVA9lXtdIh5p1P8pabdn06ozaeKWypS8rJzGwiAxmH8zXjm+LswnmTH8seE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717908891; c=relaxed/simple;
	bh=Nvt6/GPfzJORfUsoEwoBt63WIsvWrqRyEtLTN6CDWHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jC0pd19rlgHXlkc5316PWcsrRdsKpZWxznvLdj4U2iJUQfyYtr692a20JHwS5aT6AuL8U/mg23l2MsszlgQtxu2PTKhogwjnjRslICr/JorBoCEHzb6RyxKV5FJQlaw6fWCnzHuX0GX7xH5mhA7yJ2On8A6pXMRE1ZaSQIaWZY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWtyydn/; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25487d915b8so981943fac.0;
        Sat, 08 Jun 2024 21:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717908889; x=1718513689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nyGGSgr4qAOZGycJHyH7XZ3wxYvuTR2etyxkHISKPfI=;
        b=IWtyydn/jcQ1ypeqkjbbj7rs+GAzOFcmowSosgNJda7b/BlTx2YbIaXEpBZzTqytgu
         DyvCesaxnHZxu/tP0P8iJCG8YKqw1y2ChUyBNU4dBvDbdWpL0JZlkMgiO30kNfDskuaC
         hJklT92PT1skqy41M0WoTHR4s4QgxGIrZ6tEot4IEbQFpoEGxOf1gmIQC6nbwxNjaIVb
         XaovVk5QUoi1VxP5vEKK8orMfc2pUzCs3RHpWJbrULdeZbgJFNbTrls8ixhE0Ytrtn+o
         ujAHuODrGg6NEPM+uwj/NPP2b8v54sxrMQ8gmkdsMFS7LilzCJd/gt1Xc2EKv/lhqALh
         dXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717908889; x=1718513689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyGGSgr4qAOZGycJHyH7XZ3wxYvuTR2etyxkHISKPfI=;
        b=a7T6MZ6NG3z6y9/nYdRqrgpv8H4TIuRsP+c7TD5CAijBvp66PPZpNyxCH3/1+8MTTD
         0nyGwf66+O7pWkfp2a9pFd0H7uRdbcQw2oO4/Cty9xkwwz3I+N1lmH1GWjvt4IBwcC2+
         djU7XN3LvWPJaEzaEPI6qRfqhMlOCv7QtyWF7UjiwLnYnMnrNqIq+CDvPbQy+QH1yXv9
         gv2BrfrnowTV3bokuQ5rfCgwmFCV5JILCJGo9qVR49FpzAwwEQKoJ3AwHdVtxcA8clYV
         LWO6gKnz85hfVL28db0R/Ww+OYXsOXfexhcG+ou2rCbDbq3/hRc6V/aSUzctVsDy0yCq
         5NpA==
X-Forwarded-Encrypted: i=1; AJvYcCU3MWeSnyO5FxfWItJ1EP/Hpw++r76pRSIIIg2WltbVD7py0muROF1hr17I8mKkBLRShL3vi1oFrRjcez97HXLg3IbHJw0v2eC8AZ2PpGZTnCGq8r6dzCEHKfeaBQtuok8qKmYWiqGj6Gg2KbJ868P9g6rfz4Lr7KieTRGJvLuw0zlb
X-Gm-Message-State: AOJu0Ywb1K9A7H7ZvZnMWCUolYZ+bmfP8wfnoPSg96kiZXxk28arEqQs
	TjCIFBNRX4EUSr4H3ODaeJ3tZfDX0DUBxrAzftK1Yz3MkEWHjqZM
X-Google-Smtp-Source: AGHT+IHit6kuLW/CQUCsyizwvU6t8TnBUH5ftFvSLZKLb7R8UNQSqYGHukLwxVl+LAI55ojHc5PZfg==
X-Received: by 2002:a05:6870:64a9:b0:254:92a5:fa44 with SMTP id 586e51a60fabf-25492a642cdmr4182589fac.10.1717908888624;
        Sat, 08 Jun 2024 21:54:48 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7041ec6f9cesm2284887b3a.78.2024.06.08.21.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 21:54:47 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: Thomas Kopp <thomas.kopp@microchip.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 0/2] can: treewide: decorate flexible array members with __counted_by()
Date: Sun,  9 Jun 2024 13:54:17 +0900
Message-Id: <20240609045419.240265-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new __counted_by() attribute was introduced in [1]. It makes the
compiler's sanitizer aware of the actual size of a flexible array
member, allowing for additional runtime checks.

I went through the full can subtree:

  * drivers/net/can
  * include/linux/can
  * include/uapi/linux/can
  * net/can

to try to identify the flexible array members that would benefit from
this attribute.

The observation is there are not so many flexible array member in the
can subtree to begin with.

Within the few flexible array members, only a two can benefit from the
__counted_by() without complex code refactoring, namely:

  * patch 1/2: struct pciefd_board from
    drivers/net/can/peak_canfd/peak_pciefd_main.c

  * patch 2/2: struct mcp251xfd_rx_ring from
    drivers/net/can/spi/mcp251xfd/mcp251xfd.h

Below is an exhaustive list of all the candidates for which
__counted_by() could not be applied to. If something did not appear
here, it just mean that I failed to catch it during my analysis.

  * All the flexible array members which rely on the
    DECLARE_FLEX_ARRAY() helper macro are out of scope for the
    moment. Those will be reconsidered depending on the output of the
    discussion in [2].

  * struct bcm_msg_head from include/uapi/linux/can/bcm.h is a special
    case. The bcm_msg_head.frames member is polymorphic: it can be
    either of:

      * an array of struct can_frame
      * an array of struct canfd_frame

    As of now, it is declared as struct can_frame for historical
    reasons. An idea is to change the type to struct canfd_frame in
    order to reflect the upper bound, in a similar fashion as struct
    mcp251xfd_rx_ring (c.f. second patch from the series). Except
    that this structure is from the uapi, meaning that such a change
    will likely break the userland, making this a bad idea.

  * struct can_skb_priv from include/linux/can/skb.h does not have a
    count member.

  * struct pucan_tx_msg and struct pucan_rx_msg from
    include/linux/can/dev/peak_canfd.h both have a flexible array
    member d, but it is counted by the four most significant bits of
    the channel_dlc member. However __counted_by() does not accept a
    shift logic. Because the layout of this structure is dictated by
    the device API, refactor is impossible here.

  * struct kvaser_usb_net_priv from
    drivers/net/can/usb/kvaser_usb/kvaser_usb.h has the
    active_tx_contexts member but it does not represent an array
    boundary. Under normal conditions, the driver may write beyond
    kvaser_usb_net_priv.tx_contexts[kvaser_usb_net_priv.active_tx_contexts].
    Code refactoring may be considered here.

  * Finally, struct flexcan_mb from
    drivers/net/can/flexcan/flexcan-core.c and struct pciefd_rx_dma
    from drivers/net/can/peak_canfd/peak_pciefd_main.c do not have
    members to indicate the count. Because the layout of these
    structures is dictated by the device API, refactor is impossible
    here.

[1] commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
Link: https://git.kernel.org/torvalds/c/dd06e72e68bc

[2] stddef: Allow attributes to be used when creating flex arrays
Link: https://lore.kernel.org/all/20240213234023.it.219-kees@kernel.org/T/#u

CC: Kees Cook <kees@kernel.org>

Vincent Mailhol (2):
  can: peak_canfd: decorate pciefd_board.can with __counted_by()
  can: mcp251xfd: decorate mcp251xfd_rx_ring.obj with __counted_by()

 drivers/net/can/peak_canfd/peak_pciefd_main.c | 6 ++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.43.0


