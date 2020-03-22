Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60CE818EB50
	for <lists+linux-can@lfdr.de>; Sun, 22 Mar 2020 19:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgCVSDO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 22 Mar 2020 14:03:14 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:42282 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVSDO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 22 Mar 2020 14:03:14 -0400
Received: by mail-lj1-f182.google.com with SMTP id q19so11958568ljp.9
        for <linux-can@vger.kernel.org>; Sun, 22 Mar 2020 11:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2AXZsjEUb2X/d09TiU2NYwG/Irul7C95J4MmLUKjbg=;
        b=Kc79FVb7/ubhjUcPv5nGeraXBp5fvl2xERklFykAh1IJyf82Wdpqy2R5nB+KGY4Mql
         1+lNYjoVuOY08pJ7FmU5Fv2j+K+PMJ7nSB4jbLopwZhSiW/1hvCv4R3Qy3s/ERH33rIY
         KgSK1V0wHQoJA1lsQvaJ6AnplVbzli8gfxcoCnT+ff6FG8lL99ORCn/ypl/oJQAqrTY3
         tYnIvfK6Khvu7nHY2+H8wrhQMM8NS7JShAj3+xMBBBlw2O5BEsCPXcOTOAm/obHIr2/p
         Z4PWvJvJPmSAyNTzCbFu4VzgMu7Dlp8OBfYZDpG6GAC0IJrZlufSJLpfGK9FESP2ZQyt
         G9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2AXZsjEUb2X/d09TiU2NYwG/Irul7C95J4MmLUKjbg=;
        b=ENOCuKRaMJ4mlSfmdfdFpV/LkwvtFVKRTbW8Hr25tL1ADUwE2sn3QRUB6Nq3NN6mY7
         HIb8shSCDItalGXDPwW5Pi2lKSJ+/c+9YSpgEN1O+gkfM/yVIY1h8EZYwRF/XuS1nk4P
         wi0XmyON7cgXsPh7wX3BWmFMUsg/JE6RZoOdQT6I5i2GO6vL/l53ID80hDYrPVJbDpJ8
         39J3lpBcIvv0hMVSaicMwsMNub0e6EBFoYNH9kiVUR7VO5CWGRj3VbgdWuYObDKtkiu5
         ByHdopAkGJP5FDiMQvjCjuJ2jk1V9huDkNZ3wvp4hq+gOkEulwI+jALRmZcQoLF72uXo
         OhPg==
X-Gm-Message-State: ANhLgQ1nud/dh7BA9WncfynVz9qmkOCoN8AOu7wD3pBCM7CYs01H53zP
        KMpZKsJYn9wf37BF4LTmiNVD5TyVRZmhv7p3R8xiu/t+2SY=
X-Google-Smtp-Source: ADFU+vuQDcjZ3IULXfJx27rZMGfCBvcL3W0ewTpiC4GXVOIJ/ewG/GPLY7ItlJwe6SG5tAzViy69o008NRq7hG+EtnA=
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr10647407ljk.66.1584900192438;
 Sun, 22 Mar 2020 11:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAOHJ0jSS=g4rQtXGkEFocafEqQAtxEOvq5eSXBC2FY_Esb23OA@mail.gmail.com>
 <2cb68f43-a551-c69d-b43f-3b044b948142@hartkopp.net> <CAOHJ0jRQx2U1APx92DTGFGzGLY9+tds3R4Sz8Tz8+LToWx_44g@mail.gmail.com>
 <ead77f42-f0f9-9b5a-ce5a-5e7f641d8a14@hartkopp.net>
In-Reply-To: <ead77f42-f0f9-9b5a-ce5a-5e7f641d8a14@hartkopp.net>
From:   Robert Barrows <robb.barrows@gmail.com>
Date:   Sun, 22 Mar 2020 13:03:01 -0500
Message-ID: <CAOHJ0jQq80B64O6nG-aNSUhUrczVL0r4GZj-AUWcs4coiERG+Q@mail.gmail.com>
Subject: Re: How to send a CAN message while in a kernel module?
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thank you for all the direction Oliver,  I think I am on the correct path,
but now have can_send returning with a "-1" (ERESTART). I used raw_sendmsg
as a template for this and cut out (hopefully) unneeded code, but I am
concerned I cut out something I needed.  Would you mind taking another look?

Thanks.

int SendCanTime(struct timespec *tsCurrentTime) {

  struct sk_buff *skb;
  struct can_frame *frame = kmalloc(sizeof (struct can_frame), GFP_KERNEL);
  struct net_device *dev;
  int err = 0;
  int thetime = tsCurrentTime->tv_sec;

  // Set up can frame
  frame->can_id = 0x00050F93 | CAN_EFF_FLAG;
  frame->can_dlc = 6;
  frame->data[0] = 0x00;
  frame->data[1] = 0x02;
  memcpy(frame->data+2, &thetime, sizeof(int));

  // Find the netdevice named can0
  read_lock(&dev_base_lock);
  dev = first_net_device(&init_net);
  while (!strcmp(dev->name, "can0")) {
    printk(KERN_INFO "found [%s]\n", dev->name);
    dev = next_net_device(dev);
  }
  read_unlock(&dev_base_lock);

  if (!dev)
    return -ENXIO;

  // Create skb
  skb = alloc_can_skb(dev, &frame);
  if (!skb)
    goto put_dev;

  skb->dev = dev;

  err = can_send(skb, 0);

  dev_put(dev);

  if (err)
    goto send_failed;

  return 0;

//kfree_skb(skb);
put_dev:
  dev_put(dev);
send_failed:
  return err;

}
                                                                               ^
