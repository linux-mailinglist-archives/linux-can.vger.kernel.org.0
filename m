Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B235CA7999
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 06:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfIDEPZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 00:15:25 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:16812 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfIDEPZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 00:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567570523;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=rMdWUlqhVU8OBC+kVct3IUwA6LlK6d4RfsxygrgGVCw=;
        b=E6jhxAX8QQZn4mlmUZMHlP6FMWL9MoSr8L7WIfNCYprGZiri+mWu3dqhRPElUH3BtV
        GDmqqW1kWX0FiqCcXQtEgmWqZYNfNyWBFqbh1PZseRsNv8nf35s6ybuwWWJrm9o2fMHq
        kKxswfZQxpnskEF6O34yyhfrJnYAD5EhXoNmt0Vsrd8cONT5Ah9kcA8sZDdzVF4ZPM4c
        FJouDZAspaibdfwTitePHHxRak3F9yHYkgAj3yZZ/NbOXut3losUuDxeFlE4xGN4kusK
        Nr3k5wUPS0iW5f1wCFe/C9Ym0epTfdwu04y3Wm8CjONCQA2XFPmwSGQeIOvn3s9jRbiY
        XULQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1r27UaEWJ+6BEwpjB"
X-RZG-CLASS-ID: mo00
Received: from [172.31.14.27]
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id j0667fv844FMOxd
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 4 Sep 2019 06:15:22 +0200 (CEST)
Subject: Re: [PATCH 13/21] can: introduce CAN midlayer private and allocate it
 automatically
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>
References: <20190828065226.23604-1-mkl@pengutronix.de>
 <20190828065226.23604-14-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <18ba191d-4052-05a0-fc61-403b619befca@hartkopp.net>
Date:   Wed, 4 Sep 2019 06:15:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828065226.23604-14-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


On 28/08/2019 08.52, Marc Kleine-Budde wrote:
> This patch introduces the CAN midlayer private structure ("struct
> can_ml_priv") which should be used to hold protocol specific per device
> data structures. For now it's only member is "struct can_dev_rcv_lists".

> diff --git a/include/linux/can/can-ml.h b/include/linux/can/can-ml.h
> new file mode 100644
> index 000000000000..2786b04251ea
> --- /dev/null
> +++ b/include/linux/can/can-ml.h
> @@ -0,0 +1,23 @@

Dual license (GPLv2 / BSD) SPDX identifier missing here
/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */

> +/*
> + * Copyright (C) 2017 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +#ifndef CAN_ML_H
> +#define CAN_ML_H
> +
> +#include "../../net/can/af_can.h"

Arg!

Move

/* per device receive filters linked at dev->ml_priv */
struct can_dev_rcv_lists {
	struct hlist_head rx[RX_MAX];
	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
	int entries;
};

from af_can.h here.

I always tried to separate the CAN network layer from the CAN driver 
stuff. But this "deep include" smells fishy.

I applied these changes on my tree (on top of all your patches):

diff --git a/include/linux/can/can-ml.h b/include/linux/can/can-ml.h
index 9861946fe4ae..6bda2efcd570 100644
--- a/include/linux/can/can-ml.h
+++ b/include/linux/can/can-ml.h
@@ -14,7 +14,22 @@
  #ifndef CAN_ML_H
  #define CAN_ML_H

-#include "../../net/can/af_can.h"
+#include <linux/can.h>
+#include <linux/list.h>
+
+#define CAN_SFF_RCV_ARRAY_SZ (1 << CAN_SFF_ID_BITS)
+#define CAN_EFF_RCV_HASH_BITS 10
+#define CAN_EFF_RCV_ARRAY_SZ (1 << CAN_EFF_RCV_HASH_BITS)
+
+enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
+
+/* per device receive filters linked at dev->ml_priv */
+struct can_dev_rcv_lists {
+	struct hlist_head rx[RX_MAX];
+	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
+	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
+	int entries;
+};

  struct can_ml_priv {
  	struct can_dev_rcv_lists dev_rcv_lists;
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 56a31a99bc6e..7c2d9161e224 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -60,20 +60,6 @@ struct receiver {
  	struct rcu_head rcu;
  };

-#define CAN_SFF_RCV_ARRAY_SZ (1 << CAN_SFF_ID_BITS)
-#define CAN_EFF_RCV_HASH_BITS 10
-#define CAN_EFF_RCV_ARRAY_SZ (1 << CAN_EFF_RCV_HASH_BITS)
-
-enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
-
-/* per device receive filters linked at dev->ml_priv */
-struct can_dev_rcv_lists {
-	struct hlist_head rx[RX_MAX];
-	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
-	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
-	int entries;
-};
-
  /* statistic structures */

  /* can be reset e.g. by can_init_stats() */
diff --git a/net/can/proc.c b/net/can/proc.c
index 560fa3c132bf..d3697105daec 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -46,6 +46,7 @@
  #include <linux/rcupdate.h>
  #include <linux/if_arp.h>
  #include <linux/can/core.h>
+#include <linux/can/can-ml.h>

  #include "af_can.h"


Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net> attribution is 
welcome in can-ml.h

;-)

