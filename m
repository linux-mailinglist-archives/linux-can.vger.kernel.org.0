Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A31192BA2
	for <lists+linux-can@lfdr.de>; Wed, 25 Mar 2020 16:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgCYO77 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Mar 2020 10:59:59 -0400
Received: from grisu.netadair.de ([85.214.110.32]:55003 "EHLO
        h1352864.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgCYO77 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Mar 2020 10:59:59 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2020 10:59:58 EDT
Received: (qmail 23418 invoked from network); 25 Mar 2020 15:54:04 +0100
Received: from dslb-090-186-163-006.090.186.pools.vodafone-ip.de (HELO ?192.168.1.166?) (90.186.163.6)
  by grisu.netadair.de with (DHE-RSA-AES128-SHA encrypted) SMTP; 25 Mar 2020 15:54:04 +0100
To:     linux-can@vger.kernel.org
From:   Michael Rausch <mr@netadair.de>
Subject: Bug with endianess in gs_usb.c, questions
Message-ID: <b58aace7-61f3-6df7-c6df-69fee2c66906@netadair.de>
Date:   Wed, 25 Mar 2020 15:52:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello all,

it seems the gs_usb driver has an endianess problem with (at least) the candlelight firmware.

The protocol specifies data transfer in host byte order, however the candlelight fw seems to ignore this and assumes little endian data (as for the STM32).
Subsequently, this driver only works on little endian hosts...

I stumbled across this when trying to add the module to OpenWRT on the ar71xx platform (big endian MIPS), and build a patch against a fixed version, that runs 
on 9 adapters currently without problems.
This fixed version does force the protocol metadata to be little endian, thus a no-op on the the majority of hosts.
It does this either by actually preparing the metadata structures in LE, or converting the data shortly before and/or after sending. The later is done to allow 
things like filling bit fields without code change, and changing back/forth for chains reusing the structure.
Admitted, it's not handled very consistenly.

Question 1) Would the forcing of LE be ok, ie not fixing the (resp. one of the) firmware flavors but rather amending the driver?
Question 2) Would the slightly inconsistent handling of the structure filling be ok?

Best regards,
Michael
---

Diff for info purpose (actually, need to check what proper diffs look nowadays, my "kernel hacking times" are 25 years back :) :

--- ./build_dir/target-mips_24kc_musl/linux-ar71xx_generic/linux-4.14.167/drivers/net/can/usb/gs_usb.c  2020-01-23 07:20:37.000000000 +0000
+++ /data/openwrt/builds/work/backup/gs_usb.c   2020-03-17 20:17:34.909765950 +0000
@@ -253,7 +253,7 @@
         if (!dm)
                 return -ENOMEM;

-       dm->mode = GS_CAN_MODE_RESET;
+       dm->mode = cpu_to_le32(GS_CAN_MODE_RESET);

         rc = usb_control_msg(interface_to_usbdev(intf),
                              usb_sndctrlpipe(interface_to_usbdev(intf), 0),
@@ -320,6 +320,10 @@
                 return;
         }

+       /* fix candlelight firmware endianess problem */
+       hf->echo_id = le32_to_cpu(hf->echo_id);
+       hf->can_id = le32_to_cpu(hf->can_id);
+
         /* device reports out of range channel id */
         if (hf->channel >= GS_MAX_INTF)
                 goto resubmit_urb;
@@ -394,6 +398,11 @@
         }

   resubmit_urb:
+
+       /* fix candlelight firmware endianess problem, switch back to original before resend */
+       hf->echo_id = cpu_to_le32(hf->echo_id);
+       hf->can_id = cpu_to_le32(hf->can_id);
+
         usb_fill_bulk_urb(urb,
                           usbcan->udev,
                           usb_rcvbulkpipe(usbcan->udev, GSUSB_ENDPOINT_IN),
@@ -426,11 +435,11 @@
         if (!dbt)
                 return -ENOMEM;

-       dbt->prop_seg = bt->prop_seg;
-       dbt->phase_seg1 = bt->phase_seg1;
-       dbt->phase_seg2 = bt->phase_seg2;
-       dbt->sjw = bt->sjw;
-       dbt->brp = bt->brp;
+       dbt->prop_seg = cpu_to_le32(bt->prop_seg);
+       dbt->phase_seg1 = cpu_to_le32(bt->phase_seg1);
+       dbt->phase_seg2 = cpu_to_le32(bt->phase_seg2);
+       dbt->sjw = cpu_to_le32(bt->sjw);
+       dbt->brp = cpu_to_le32(bt->brp);

         /* request bit timings */
         rc = usb_control_msg(interface_to_usbdev(intf),
@@ -506,12 +515,12 @@
                 goto badidx;
         }

-       hf->echo_id = idx;
+       hf->echo_id = cpu_to_le32(idx);
         hf->channel = dev->channel;

         cf = (struct can_frame *)skb->data;

-       hf->can_id = cf->can_id;
+       hf->can_id = cpu_to_le32(cf->can_id);
         hf->can_dlc = cf->can_dlc;
         memcpy(hf->data, cf->data, cf->can_dlc);

@@ -664,8 +673,12 @@
         if (ctrlmode & CAN_CTRLMODE_3_SAMPLES)
                 dm->flags |= GS_CAN_MODE_TRIPLE_SAMPLE;

+       /* fix candlelight firmware endianess problem */
+       dm->mode = cpu_to_le32(dm->mode);
+       dm->flags = cpu_to_le32(dm->flags);
+
         /* finally start device */
-       dm->mode = GS_CAN_MODE_START;
+       dm->mode = cpu_to_le32(GS_CAN_MODE_START);
         rc = usb_control_msg(interface_to_usbdev(dev->iface),
                              usb_sndctrlpipe(interface_to_usbdev(dev->iface), 0),
                              GS_USB_BREQ_MODE,
@@ -745,9 +758,9 @@
                 return -ENOMEM;

         if (do_identify)
-               imode->mode = GS_CAN_IDENTIFY_ON;
+               imode->mode = cpu_to_le32(GS_CAN_IDENTIFY_ON);
         else
-               imode->mode = GS_CAN_IDENTIFY_OFF;
+               imode->mode = cpu_to_le32(GS_CAN_IDENTIFY_OFF);

         rc = usb_control_msg(interface_to_usbdev(dev->iface),
                              usb_sndctrlpipe(interface_to_usbdev(dev->iface),
@@ -838,14 +851,14 @@

         /* dev settup */
         strcpy(dev->bt_const.name, "gs_usb");
-       dev->bt_const.tseg1_min = bt_const->tseg1_min;
-       dev->bt_const.tseg1_max = bt_const->tseg1_max;
-       dev->bt_const.tseg2_min = bt_const->tseg2_min;
-       dev->bt_const.tseg2_max = bt_const->tseg2_max;
-       dev->bt_const.sjw_max = bt_const->sjw_max;
-       dev->bt_const.brp_min = bt_const->brp_min;
-       dev->bt_const.brp_max = bt_const->brp_max;
-       dev->bt_const.brp_inc = bt_const->brp_inc;
+       dev->bt_const.tseg1_min = le32_to_cpu(bt_const->tseg1_min);
+       dev->bt_const.tseg1_max = le32_to_cpu(bt_const->tseg1_max);
+       dev->bt_const.tseg2_min = le32_to_cpu(bt_const->tseg2_min);
+       dev->bt_const.tseg2_max = le32_to_cpu(bt_const->tseg2_max);
+       dev->bt_const.sjw_max = le32_to_cpu(bt_const->sjw_max);
+       dev->bt_const.brp_min = le32_to_cpu(bt_const->brp_min);
+       dev->bt_const.brp_max = le32_to_cpu(bt_const->brp_max);
+       dev->bt_const.brp_inc = le32_to_cpu(bt_const->brp_inc);

         dev->udev = interface_to_usbdev(intf);
         dev->iface = intf;
@@ -860,14 +873,16 @@
                 dev->tx_context[rc].echo_id = GS_MAX_TX_URBS;
         }

-       /* can settup */
+       /* can setup */
         dev->can.state = CAN_STATE_STOPPED;
-       dev->can.clock.freq = bt_const->fclk_can;
+       dev->can.clock.freq = le32_to_cpu(bt_const->fclk_can);
         dev->can.bittiming_const = &dev->bt_const;
         dev->can.do_set_bittiming = gs_usb_set_bittiming;

         dev->can.ctrlmode_supported = 0;

+       bt_const->feature = le32_to_cpu(bt_const->feature);
+
         if (bt_const->feature & GS_CAN_FEATURE_LISTEN_ONLY)
                 dev->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;

@@ -918,7 +933,8 @@
         if (!hconf)
                 return -ENOMEM;

-       hconf->byte_order = 0x0000beef;
+       /* fix candlelight firmware problem by sticking to little-endian byte order */
+       hconf->byte_order = cpu_to_le32(0x0000beef);

         /* send host config */
         rc = usb_control_msg(interface_to_usbdev(intf),
@@ -960,6 +976,9 @@
                 return rc;
         }

+       dconf->hw_version = le32_to_cpu(dconf->hw_version);
+       dconf->sw_version = le32_to_cpu(dconf->sw_version);
+
         icount = dconf->icount + 1;
         dev_info(&intf->dev, "Configuring for %d interfaces\n", icount);



