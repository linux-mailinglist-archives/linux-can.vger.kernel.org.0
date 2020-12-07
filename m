Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72712D0942
	for <lists+linux-can@lfdr.de>; Mon,  7 Dec 2020 04:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgLGC66 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 6 Dec 2020 21:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLGC65 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 6 Dec 2020 21:58:57 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B90C0613D0
        for <linux-can@vger.kernel.org>; Sun,  6 Dec 2020 18:58:11 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id l11so15957265lfg.0
        for <linux-can@vger.kernel.org>; Sun, 06 Dec 2020 18:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=N2cz6JXIzuD7NLPiswYmGZhB8TbirxDF+xSoUNoc5ag=;
        b=mZ2vuar5tL9Dz4eKuyVTwecMANET2918slcl0Oi5rJtH+n63Iq7OzUNDUj63tYOqN5
         /xhFUq5WlWDpIavnKMkPnZDIsTaDKri+RD+RMG0X/fDykOE0D7O+stiEYpLPE4mQk8Zd
         6JcGg7e7cz0nSPJdAxUdhJXnmRtW9cffIq8+TlELx+syzrOPl3dZIs8AmaFRRFDCC0lW
         UHlpIJSPBQoCPRxfLlIIYndhsSw1SyDj5aIz3SCkGNlzwZ8h8Pm4lHEyV6LFB0JW6GTb
         WFKPGTUbvd2pD0oEwhg7OgZ9BARUOeNXEzdK0ZTJHym9sU03xFS6sFU5Z1NKusOZWC7l
         x4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=N2cz6JXIzuD7NLPiswYmGZhB8TbirxDF+xSoUNoc5ag=;
        b=WlZO1skK7E4Ixq2aPtFi9ByIHGFjYiMmb67Bq4VqKElyt6rMm5bZesjBU3Ux8FHDvi
         j3h3DYwuoJ1hiqq0vj1nkdv2pYCcYpxz7iyyuX/tEqVZ5VDRt1b/STWl3IjemqZQF9ml
         1ILk2QNEvVxV4C91Q3elKRn0DhmM0QavmwD1IZkvZUGg0M3qNKhWZvGpmFWUFZjHVaLK
         8zX/UQ6EHjhWBU5OjWaOyRe7/UjNJMCq9eBAo/gBjDWPUrkiUhE0w65xZI6oozSMtZh4
         DPlluqZBkC59FXM+aHCyDINe4CSlTamzEpQ9pBfS5I+aoG2vPNEKbs9Jl3WDGUoCbBlm
         KdxQ==
X-Gm-Message-State: AOAM532/Wh8xccOHDFrziUUcSQi2MCDyZfirNHI4sRDeRFlY0icyg/k9
        G2e28nj8FUY53yILI4L6Cy85qudfliNnWAPN62HwmXJxvkAN+A==
X-Google-Smtp-Source: ABdhPJxQlIl46tXZsUzF0BumlwNI54lqXpVTgFTXygbx0sWBE3Lr1wvtiQFobq5kobruH8d+Ra78Ct/qiXq+8Bsm4JM=
X-Received: by 2002:ac2:41ca:: with SMTP id d10mr7423947lfi.419.1607309888853;
 Sun, 06 Dec 2020 18:58:08 -0800 (PST)
MIME-Version: 1.0
From:   Christian Gagneraud <chgans@gmail.com>
Date:   Mon, 7 Dec 2020 15:57:57 +1300
Message-ID: <CABxGUThzGkCerMBTuA95TCs49hjHg+O-u3Z_c8=RZGJ8bVQjRQ@mail.gmail.com>
Subject: New USB driver, looking for advice
To:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

I'm looking at creating a new CAN driver for a USB device [1].
This device has a custom protocol over bulk endpoints.
I was able to create a simple driver, based on usb-skeleton.c that
allows to speak this protocol by opening a custom har device.
I've been looking at the current implementation in [2], I think my
device is a bit special, you cannot read CAN frames w/o sending a
'read' command, so i need some sort of polling.
AFAIK, the Linux USB stack provides that for me, except that the
device won't read anything unless you send it a command.
I have the feeling that current drivers are for devices that can
return data by just scheduling read transfer.
Anyone would have a clue on how these drivers work, and if my device
is really that special?

Any hint, point out or reading pointers are much appreciated.

Thanks,
Chris

PS: This is for marine applications, NMEA2000 which uses CAN HW and is
wire-compatible with J1939

[1] https://www.simrad-yachting.com/simrad/type/accessories/cables-connectors/navico-can-to-usb-converter-st10/
[2] https://github.com/torvalds/linux/tree/master/drivers/net/can/usb
