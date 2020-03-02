Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 430A51753D0
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2020 07:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCBGaK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 2 Mar 2020 01:30:10 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:39953 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgCBGaJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 Mar 2020 01:30:09 -0500
Received: by mail-io1-f71.google.com with SMTP id m24so7506348iol.7
        for <linux-can@vger.kernel.org>; Sun, 01 Mar 2020 22:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4YYMt/NmjzWA++n+f1JrmgMPppH69EcF6rf66gBwOAQ=;
        b=AHhaRnprmw+65BzW3KjO+/p2YgWNa2x/jhsIkSwcI5toF0ZQGP8DF4q9NQ4tuamhrz
         l8IGzzK1I0v7i7EFC74IWG+3bAEhJKKoRwdUmx1a9myq+ax2LF55sn0CyaSj4fF2dJFM
         BpiCh9YsABG38m+OS7TrTfR+GJ54pQ9AMhzFrcEjqKP7cCLIi1eb/bukkRrQh3/xR0Ke
         vgiy0S6H4cRuVfwAJV6O2lg+uKsbJnMlY+C9SNA3k99Km8Z5Zcx5rP5HsEicSMLX2W32
         5gcxYPOUa4qj90sUS7QQXqaLhITnDtC7mY20lKSsDR5/PJOv61koO9KnrItpOIoztaSC
         hhUw==
X-Gm-Message-State: APjAAAXs/7SZRc3INe+M0w1ceoSsZnx06RycsXyezGPfdJULOj99oJGF
        secj37v5NXGEglDQnFnQXz+UEv6VkuUJcfrah8hCKbOwMwIt
X-Google-Smtp-Source: APXvYqxO00LLlC0E59VXlspGx5WEkQ2/lGhvq9JtGOFZlbtjoSv4GLYjpozDO1f5VgJgyv2k+3MwmO9OuUPzoUF9IW31DADJl64C
MIME-Version: 1.0
X-Received: by 2002:a5e:a703:: with SMTP id b3mr8643903iod.95.1583130609317;
 Sun, 01 Mar 2020 22:30:09 -0800 (PST)
Date:   Sun, 01 Mar 2020 22:30:09 -0800
In-Reply-To: <0000000000000e4f720598bb95f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099fb63059fd95165@google.com>
Subject: Re: KASAN: use-after-free Read in slcan_open
From:   syzbot <syzbot+b5ec6fd05ab552a78532@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dvyukov@google.com, jouni.hogander@unikie.com,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        mkl@pengutronix.de, netdev@vger.kernel.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com, wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This bug is marked as fixed by commit:
slcan: Fix use-after-free Read in slcan_open
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
