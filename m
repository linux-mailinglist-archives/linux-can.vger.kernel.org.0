Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA0728DC2A
	for <lists+linux-can@lfdr.de>; Wed, 14 Oct 2020 10:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgJNI6O (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 14 Oct 2020 04:58:14 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:1092 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgJNI6O (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 14 Oct 2020 04:58:14 -0400
Received: from localhost.localdomain (unknown [89.158.155.184])
        (Authenticated sender: stephane.grosjean)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id CB3A35FFBA;
        Wed, 14 Oct 2020 10:57:36 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Fabian Inostroza <fabianinostrozap@gmail.com>
Subject: [PATCH v2] can/peak_usb: fix timestamp wrapping
Date:   Wed, 14 Oct 2020 10:56:31 +0200
Message-Id: <20201014085631.15128-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fabian Inostroza <fabianinostrozap@gmail.com> has discovered a potential
problem in the hardware timestamp reporting from the PCAN-USB USB CAN
interface (only), related to the fact that a timestamp of an event may
precede the timestamp used for synchronization when both records are part
of the same USB packet. However, this case was used to detect the wrapping
of the time counter.

This patch details and fixes the two identified cases where this problem
can occur.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 v2:
 - to detect if 'ts' has wrapped, compare it with previous sync timestamp
   'ts_dev_1' instead of 'ts_period': under no circumstances could the
   event have happened BEFORE the PREVIOUS sync event. This avoid
   considering that case as if 'ts' had wrapped:

       < ts_period >
      |             |
   --0+--------+----+--------->
      ts_dev_1 |    ts_dev_2
               ts

   that is:
   - ts_dev1 very close (or equal) to 0
   - ts event also occurs BEFORE the THEORETICAL ts_period delay

 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 51 ++++++++++++++++++--
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 0b7766b715fd..267ddc18ed51 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -130,14 +130,55 @@ void peak_usb_get_ts_time(struct peak_time_ref *time_ref, u32 ts, ktime_t *time)
 	/* protect from getting time before setting now */
 	if (ktime_to_ns(time_ref->tv_host)) {
 		u64 delta_us;
+		s64 delta_ts = 0;
+
+		/* General case: dev_ts_1 < dev_ts_2 < ts, with:
+		 *
+		 * - dev_ts_1 = previous sync timestamp
+		 * - dev_ts_2 = last sync timestamp
+		 * - ts = event timestamp
+		 * - ts_period = known sync period (theoretical)
+		 *             ~ dev_ts2 - dev_ts1
+		 * *but*:
+		 *
+		 * - time counters wrap (see adapter->ts_used_bits)
+		 * - sometimes, dev_ts_1 < ts < dev_ts2
+		 *
+		 * "normal" case (sync time counters increase):
+		 * must take into account case when ts wraps (tsw)
+		 *
+		 *      < ts_period > <          >
+		 *     |             |            |
+		 *  ---+--------+----+-------0-+--+-->
+		 *     ts_dev_1 |    ts_dev_2  |
+		 *              ts             tsw
+		 */
+		if (time_ref->ts_dev_1 < time_ref->ts_dev_2) {
+			/* case when event time (tsw) wraps */
+			if (ts < time_ref->ts_dev_1)
+				delta_ts = 1 << time_ref->adapter->ts_used_bits;
+
+		/* Otherwise, sync time counter (ts_dev_2) has wrapped:
+		 * handle case when event time (tsn) hasn't.
+		 *
+		 *      < ts_period > <          >
+		 *     |             |            |
+		 *  ---+--------+--0-+---------+--+-->
+		 *     ts_dev_1 |    ts_dev_2  |
+		 *              tsn            ts
+		 */
+		} else if (time_ref->ts_dev_1 < ts) {
+			delta_ts = -(1 << time_ref->adapter->ts_used_bits);
+		}
 
-		delta_us = ts - time_ref->ts_dev_2;
-		if (ts < time_ref->ts_dev_2)
-			delta_us &= (1 << time_ref->adapter->ts_used_bits) - 1;
+		/* add delay between last sync and event timestamps */
+		delta_ts += (signed int)(ts - time_ref->ts_dev_2);
 
-		delta_us += time_ref->ts_total;
+		/* add time from beginning to last sync */
+		delta_ts += time_ref->ts_total;
 
-		delta_us *= time_ref->adapter->us_per_ts_scale;
+		/* convert ticks number into microseconds */
+		delta_us = delta_ts * time_ref->adapter->us_per_ts_scale;
 		delta_us >>= time_ref->adapter->us_per_ts_shift;
 
 		*time = ktime_add_us(time_ref->tv_host_0, delta_us);
-- 
2.25.1

