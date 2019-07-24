Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A629723AD
	for <lists+linux-can@lfdr.de>; Wed, 24 Jul 2019 03:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfGXB23 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Jul 2019 21:28:29 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:40158 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfGXB23 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Jul 2019 21:28:29 -0400
Received: by mail-lj1-f170.google.com with SMTP id m8so9260697lji.7
        for <linux-can@vger.kernel.org>; Tue, 23 Jul 2019 18:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=capp-tech-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=18eY1/tunZBkCtHfkOl+vLsgM/fdaJLtLzBQ8CqrT3A=;
        b=XlkwLpg409cnxFaD4mPkQ7lgU2atZCF3dizV0C2DBA2Ya4Vp1JGLIKhUklxYxXybO6
         oeW2FAPuQANhD+8X6/jGV+D7ygbnCQWcRhGmCf/V/ocMC9V/7WYnM/SKiaUv92rXfBNR
         5zQ+Df5g0FuOvyUYnDNPtN/zn+ubFtt+ZB44/mbCg49IboXCBQxHrbjYbYsXk6IAFruZ
         1d6mMADu8ZAr1YtGeGXFQEb5dz2fwtjiUJhpc+6ZuE8+JAtLkITMQ3mjKkwB6tljgClH
         UjPiJPqjo5BcYHAi1x6Nibo5TYQeumam+YW+qLDFHKUlte80YEv8vOwC+2fx3YVd+uFa
         FLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=18eY1/tunZBkCtHfkOl+vLsgM/fdaJLtLzBQ8CqrT3A=;
        b=bF4HVh7Jg7gn55rkP+4NxJihmNSAyjoY26bEPZ8+ebk9kYUVPLlicRYmWgqolWv4Gs
         8xUO8/WwuFOsWputlgsP3kWBmNPlfInXqNLyxceWLCyFKG3K7eetes9v9EXYC+I1fb2r
         eGpUy+OLqIhTJ39aLAVla3VzK8ViL3BmcJMKDXSFJg0oQk967v4srEQH04VcNV2/Plis
         kbqroymAvWPFw32SKqfmQW95ubunM7i+5GizOHYzvu3zeCC0eamovz6h1wiPNbZhbRBD
         8NbHdzHRSmatx762mJ5zTafR7vK8nFsQSdl+3v49rLKsur4TQqmr4R+HSkTBDdS5wWAQ
         nhFw==
X-Gm-Message-State: APjAAAXX8uVTB0zUpJGWMVJEH/0C+FD3TVYrXD/FyyseHSDronL7L56i
        9pXGRgv9I9xXZWy8dhn2yvHEfqv/sU72N77haYEs/bIce978zg==
X-Google-Smtp-Source: APXvYqzXGVpp1vhRNHpBEH24DCn4WGNQfYrFx1zM/ezEAB57NWg8K9nLf2+pQXVg4ApUycCQeJAgOP6qIXfDSCFGcYw=
X-Received: by 2002:a2e:93c5:: with SMTP id p5mr40309046ljh.79.1563931706807;
 Tue, 23 Jul 2019 18:28:26 -0700 (PDT)
MIME-Version: 1.0
From:   Tom Prohaszka <tprohaszka@capp-tech.com>
Date:   Tue, 23 Jul 2019 21:28:15 -0400
Message-ID: <CANRGksjUg8r5zwCpnat_UhX0EP3PDcyazApNSxqc6R_iu0Tqtg@mail.gmail.com>
Subject: Microchip mcp25xxfd can controller driver- BUG: using
 __this_cpu_add() in preemptible
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

We implemented the MCP25xxfd driver patch V7 and are experiencing an
issue when the CPU load for the mcp25xxfd driver is over 30%.  Using
CANDump or our custom application, we see:

root@ccimx6ulcvdp:~/tmp# BUG: using __this_cpu_add() in preemptible
[00000000] code: irq/194-mcp25xx/805

When this occurs, the kernel eventually crashes.  Has this been seen
by anyone, or any suggestions on what could cause this?

Our system is:
CAN 2.0 Std, 500Kbps, Tx/Rx enabled, but only Receiving CAN messages
Digi Imx6ul,
MCP2517 clk 40Mhz
SPI Clk 12 Mhz
Linux version 4.9.65-dey+gf832589 (gcc version 6.2.0 (GCC) ) #41 SMP
PREEMPT Sun Jul 7 21:39:25 EDT 2019

On a secondary question, in the driver comments, it was mentioned that
transfer rate was >99% with no network statistics, but when network
statistics are used, the transfer rate drops 60%.
We don't care about network statistics, can you provide info on how
you turned this off?

Thanks.
Tom
