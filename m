Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 953D76467B
	for <lists+linux-can@lfdr.de>; Wed, 10 Jul 2019 14:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfGJMpy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 Jul 2019 08:45:54 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:46408 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJMpy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 Jul 2019 08:45:54 -0400
Received: by mail-oi1-f170.google.com with SMTP id 65so1473956oid.13
        for <linux-can@vger.kernel.org>; Wed, 10 Jul 2019 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kS7oPLEo0ZTSdbCLejYJMNw/YHbs1J/7X5ekioDYTcY=;
        b=cpXTaKQ7d59kU0xcm1VQmt5Pz4JG6iKHZU5afXSai2r6w+CsnnApl+H2udbR7cFS76
         bgqdwLs18nFAgb/PNqPV1z7TpeM5gZMpX4HcF9eSS6lrcsQvelspiq5xt9CMx0hiHsvh
         WSLsdwhs9EsR8DwUQlBqOXP3EyCWpCe8p13gi2hy0bOdVkJdz76DEryjW/oeBAma0aNr
         6r6ANbQkxDSj125AJYc7GjmMHbdvHXWsnUX3aya2apdmjWuMfF7qXE6HsEJ118GLNQbN
         SnwDx3Kr2hGfLpb3BdfvQYfSqI+dOfoDBXBkPFdrHYbOazrXK0S4ycYnHEWDpuoaff3p
         ntiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kS7oPLEo0ZTSdbCLejYJMNw/YHbs1J/7X5ekioDYTcY=;
        b=KXQLcMcxM59/bFE33WRPm8fxMYqaYECLEi7WKOD3N1I6lqKzqBSIRM/7vmmRWGjS/2
         aY113AYH7c9iEVum9D7Ylet9i/Db9W9S3mJSZbW/da1XWCiH4D3zjV7Id6iAlKXywFvi
         XaCQpdPzry2V8ohgN/ulWD89G6tQu4sj4crn372GCRmD9igHEVihtzZhrRxnIsb5I6eC
         NNdEJWWlpymCb5IbXwzvkJzY8OFovusg6FWllWHhVIQNbKfgZHI6nv/jasrq0sKhl3h8
         sgpgglw2QcWLHF3eEARZKLHA23btqZbOTJH0b7kvOBDVL9p5wm2ea/TyKhHcEDp/rwvz
         Mz8A==
X-Gm-Message-State: APjAAAWtjD5m4SPUEOs3SW/7uHMkVcqr1MNxJJDaG5OBa/NCjpFm+MVK
        LXQaeK2N6b08OYMOKL4RaQ5aBeI9UvR3r55LZ364Rw==
X-Google-Smtp-Source: APXvYqyaAWFsp2m1lCTJ/WSNFZMWVqLCUhQtVvD5oyExm83WogKiN6EG0jTgycJS6YmXNZWTUSoGRGjOpV/f3Q0cpHA=
X-Received: by 2002:aca:55c2:: with SMTP id j185mr3464021oib.100.1562762752715;
 Wed, 10 Jul 2019 05:45:52 -0700 (PDT)
MIME-Version: 1.0
From:   laurent vaudoit <laurent.vaudoit@gmail.com>
Date:   Wed, 10 Jul 2019 14:45:41 +0200
Message-ID: <CAA7hF3zC2SrgC6JaKWzTDE6L6bP2o=zM_ZwdXgU7hwfJMraiCA@mail.gmail.com>
Subject: BCM on ethernet link
To:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,
we are using CAN-BCM protocol for communication between two cpu (one
with Linux, the other one without OS).
The communication is basically exchanging some data periodically
between the 2 cpus (to keep data synchronous between the 2 side)

On a futur architecture of the board, we plan to get some ethernet
link between the 2 CPUs instead of CAN.
But with still a "Linux CPU" and the other one without OS (which
exclude too complex implementation).

So my idea was to write a driver inspired from can-bcm, but instead of
using can frame using some TCP or UDP socket.  Userspace would use
netlink socket to communicate with the driver, as this would not be a
AF_CAN driver.

But before starting this work, i was wondering:
-if it is the good choice?
-if there  is some existing implementation which could be the good
choice, or a better start point?

Thanks in advance for your advice

Regards
Laurent
