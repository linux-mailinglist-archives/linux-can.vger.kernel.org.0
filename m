Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4BF21903B2
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2020 03:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCXC4F (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 23 Mar 2020 22:56:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39486 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgCXC4F (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 23 Mar 2020 22:56:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id j15so11969782lfk.6
        for <linux-can@vger.kernel.org>; Mon, 23 Mar 2020 19:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=oxWAPx5/f6CdTX/W6//xSc3O58WL1ISSs1ON7g5EjdQ=;
        b=U44N0SvabSLzgFgARkmEofz58CynP92mZ/kB5gs40KRBnzLvP8HAUCfjaeMkpGd4rz
         l3s7pXPgfqK1a0mtFvZTJLHuX9XGk+V/R+94533kIh8d9tsRURowpHv3yzr397L9qiVK
         o3aGLi2ncUlP4T5yFSDmzqCYJ7NOc26MVV9wASboCHqwvY+JS2mmqdo+36FMpugbxYY4
         4EC+UFjK/sirXyx4LvvcU9t9tcWDoc3f1WyxgIpKpBygyDWm6G2/h3m1POEIsOX4G6iN
         9VkyZ8kJLD8ULbFYxv4HxWSrPE3fzq4KzyFabUd9IMALI1k+Ol2eAMwvuXvlXmtLkXya
         rncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oxWAPx5/f6CdTX/W6//xSc3O58WL1ISSs1ON7g5EjdQ=;
        b=tvYXvGDipUj+Mp9WuYZbJP0vO0ZToSwa4umWvujPGQSl+ZOIfH3Lpb+hyn2ch5JMGI
         dpNAct+cMEiOfhswvGvlVlh9/oVga6aAvw0AnGeZojmtNGzi4wRy29OY8TVlY2KuSybF
         7scdYVRZhlUbnzW9EJhc29vYwGdimvdWNvXzyFTZ670mj+zCoWUQrtdQy/0Oor5j1BrI
         7HSxyGPqzYlzP3tNAg9zITXNyeMWDwDPzLgMgC5t61d6L7pBI26fwva6hPX6CqCgWhOl
         lheqFHjiD7tLeT1IVreTf8Yui5svIde9h77B1IdNF4J35+1DaM7ADmnV+y/9g8cBOG71
         gaPQ==
X-Gm-Message-State: ANhLgQ37nU4YIuNzpJmACBe7nYU3TYlxZW2VsRuffOChpJ+xrE1TendH
        tMUAGq3scdrIOUtVWZFvbcz/VH393zXcqW+JsXjb45zOYV4=
X-Google-Smtp-Source: ADFU+vvZn2acR9OLOos+hWY+adxv8gDZCofRPKaCZ9lDuUcyMaI2VsEt2A1PjJJpgXIRK+XXsDU9mx3s892tl0RyOaM=
X-Received: by 2002:a19:6449:: with SMTP id b9mr15077007lfj.5.1585018561971;
 Mon, 23 Mar 2020 19:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAOHJ0jSS=g4rQtXGkEFocafEqQAtxEOvq5eSXBC2FY_Esb23OA@mail.gmail.com>
 <2cb68f43-a551-c69d-b43f-3b044b948142@hartkopp.net> <CAOHJ0jRQx2U1APx92DTGFGzGLY9+tds3R4Sz8Tz8+LToWx_44g@mail.gmail.com>
 <ead77f42-f0f9-9b5a-ce5a-5e7f641d8a14@hartkopp.net> <CAOHJ0jQq80B64O6nG-aNSUhUrczVL0r4GZj-AUWcs4coiERG+Q@mail.gmail.com>
 <a152f1b1-f9e4-cae2-4dc4-d651f84eb11b@hartkopp.net>
In-Reply-To: <a152f1b1-f9e4-cae2-4dc4-d651f84eb11b@hartkopp.net>
From:   Robert Barrows <robb.barrows@gmail.com>
Date:   Mon, 23 Mar 2020 21:55:50 -0500
Message-ID: <CAOHJ0jTFiJRvunaKNjaqcsFJ0JdB8CJJor4tG9x-4mcOH6i=Tw@mail.gmail.com>
Subject: Re: How to send a CAN message while in a kernel module?
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thank you for all the help it seems I have everything working and am able to
hit sub 20uS accuracy.  Is there any concern with my HR timer ISR interrupting
a currently pending CAN message that is only partially done, thus sending my
packet in "the middle" of another one?  Or is each packet in the can driver
sent as an atomic event?

If you are curious, here were my initial results:

 (1584977760.000001)  can0  00050F93   [6]  00 02 5F D7 78 5E
 (1584977761.999995)  can0  00050F93   [6]  00 02 61 D7 78 5E
 (1584977763.999993)  can0  00050F93   [6]  00 02 63 D7 78 5E
 (1584977766.000002)  can0  00050F93   [6]  00 02 65 D7 78 5E
 (1584977767.999996)  can0  00050F93   [6]  00 02 67 D7 78 5E
 (1584977769.999999)  can0  00050F93   [6]  00 02 69 D7 78 5E
 (1584977772.000002)  can0  00050F93   [6]  00 02 6B D7 78 5E
 (1584977774.000001)  can0  00050F93   [6]  00 02 6D D7 78 5E
 (1584977776.000000)  can0  00050F93   [6]  00 02 6F D7 78 5E
 (1584977778.000000)  can0  00050F93   [6]  00 02 71 D7 78 5E
 (1584977779.999997)  can0  00050F93   [6]  00 02 73 D7 78 5E
 (1584977781.999999)  can0  00050F93   [6]  00 02 75 D7 78 5E
 (1584977783.999996)  can0  00050F93   [6]  00 02 77 D7 78 5E
 (1584977786.000022)  can0  00050F93   [6]  00 02 79 D7 78 5E
 (1584977788.000000)  can0  00050F93   [6]  00 02 7B D7 78 5E

And my current functioning code:

int SendCanTime(struct timespec *tsCurrentTime) {

  struct can_frame frame;
  struct can_frame *cf = &frame;
  struct sk_buff *skb;
  int thetime = tsCurrentTime->tv_sec;
  struct net_device *dev;
  int err;

  // Find the netdevice named can0
  dev = __dev_get_by_name(&init_net,"can0");
  if (!dev)
    return -ENXIO;

  // Create skb
  skb = alloc_can_skb(dev, &cf);
  if (!skb) {
    dev_put(dev);
    return 1;
  }

  skb->dev = dev;

  // Set up can frame
  cf->can_id = 0x00050F93 | CAN_EFF_FLAG;
  cf->can_dlc = 6;
  cf->data[0] = 0x00;
  cf->data[1] = 0x02;
  memcpy(cf->data+2, &thetime, sizeof(int));

  err = can_send(skb, 1);

  if(err) {
    dev_put(skb->dev);


    return 1;
  }
  return 0;
}

                                                                               ^

                                                                               ^


On Sun, Mar 22, 2020 at 1:55 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
>
>
> On 22/03/2020 19.03, Robert Barrows wrote:
> > Thank you for all the direction Oliver,  I think I am on the correct path,
> > but now have can_send returning with a "-1" (ERESTART). I used raw_sendmsg
> > as a template for this and cut out (hopefully) unneeded code, but I am
> > concerned I cut out something I needed.  Would you mind taking another look?
> >
> > Thanks.
> >
> > int SendCanTime(struct timespec *tsCurrentTime) {
> >
> >    struct sk_buff *skb;
> >    struct can_frame *frame = kmalloc(sizeof (struct can_frame), GFP_KERNEL);
> >    struct net_device *dev;
> >    int err = 0;
> >    int thetime = tsCurrentTime->tv_sec;
> >
> >    // Set up can frame
> >    frame->can_id = 0x00050F93 | CAN_EFF_FLAG;
> >    frame->can_dlc = 6;
> >    frame->data[0] = 0x00;
> >    frame->data[1] = 0x02;
> >    memcpy(frame->data+2, &thetime, sizeof(int));
> >
> >    // Find the netdevice named can0
> >    read_lock(&dev_base_lock);
> >    dev = first_net_device(&init_net);
> >    while (!strcmp(dev->name, "can0")) {
> >      printk(KERN_INFO "found [%s]\n", dev->name);
> >      dev = next_net_device(dev);
> >    }
> >    read_unlock(&dev_base_lock);
>
> What does this return when you don't have can0 in the system??
>
> You should use
>   __dev_get_by_name()
> here.
> https://elixir.bootlin.com/linux/latest/source/net/core/dev.c#L762
>
> And check for success :-)
>
>
> >
> >    if (!dev)
> >      return -ENXIO;
> >
> >    // Create skb
> >    skb = alloc_can_skb(dev, &frame);
> >    if (!skb)
> >      goto put_dev;
> >
> >    skb->dev = dev;
> >
> >    err = can_send(skb, 0);
> >
> >    dev_put(dev);
> >
> >    if (err)
> >      goto send_failed;
> >
> >    return 0;
> >
> > //kfree_skb(skb);
> > put_dev:
> >    dev_put(dev);
> > send_failed:
> >    return err;
> >
> > }
> >                                                                                 ^
> >
