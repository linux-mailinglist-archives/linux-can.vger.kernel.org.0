Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D1F153F6C
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2020 08:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgBFHz5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Feb 2020 02:55:57 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:39035 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgBFHz5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Feb 2020 02:55:57 -0500
Received: by mail-il1-f179.google.com with SMTP id f70so4279271ill.6
        for <linux-can@vger.kernel.org>; Wed, 05 Feb 2020 23:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=W1VwlywbXof6paa9wXAsFM+Ol4rKyO/SKTSqQhaTDZM=;
        b=q752oKkefLhBuxXCvysmyjMF9bh+t05K/CFde3s4gPrWxeHvkiM2A22PtZRcU7IGMn
         ayKhfETYNjsuDMUKld2J7Ge9uQuOm8nh2lGgyK104oG2pGmoiafquniF/YsWiQ2pi4uV
         I4Nngjr4O5ZeOkSTP54eHlh8pf6n1KMp0WAlxz8Sjybel+pHooHptFNkuZH5GsUmAAgc
         16ISfj3YJT45th1Q5PjSraQ5JlKdLjCrLjxX/S7Vv5mjLkbQb5GSLKtQsPdVznchyX9O
         XJSPkE/VfL3zJL8m/t1u3HvHtzj2IBqymlPPtqp6xzleQWgb2rdhkzo5lnjF5YNek0DF
         4ItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=W1VwlywbXof6paa9wXAsFM+Ol4rKyO/SKTSqQhaTDZM=;
        b=aZab7H9Sxki/o+CMpOQeozC1u752g1i0gD9opCwppFC535t79fwbD7FWKFyJRXQ03/
         I7fjIyjXb538egbYFgGZhFhU7pzgPK15kQJpV3uvLUxr2Dn7pl6aDg/LlRqNYhGO9CHd
         O05HJVbTW+6P+x+4YSxQlCWxnrGt5oZdR6/d6s3hR/3sJVrRqpc95m1dYqf5KNOd07hT
         MN+Akt3FJCkOKVJImW44PrNvBkdldV98j6z5H6VRVulG6d2PeQj8jT5nacwHpvB/kkWm
         X6EyZPd80xqEyqoAXqMCtOhmHyTyWi0oRZdNJemxvpgN5NF1irjhYUTrDPWfIVBklg3K
         PPNg==
X-Gm-Message-State: APjAAAWi+8Zt8W2EFOu882tOh8OMJDQwmwKjSrpbxc3yr5kNCJS+kn6A
        o4BOCHOuTZ3wJmUvvUxvQeUUId0kFW0QDy2sI9i15y0rlSI=
X-Google-Smtp-Source: APXvYqw6MtCTKaKn/np065SpCFN7zkUvVW6Gxu+vSV2RBjXfqtcDhLjPPV9CDAD/GHSyCZrdT/1hxd4rPUpSHQPXAVI=
X-Received: by 2002:a92:5c8f:: with SMTP id d15mr2747688ilg.102.1580975756804;
 Wed, 05 Feb 2020 23:55:56 -0800 (PST)
MIME-Version: 1.0
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Thu, 6 Feb 2020 09:55:46 +0200
Message-ID: <CAP22eLE2ro96aZymd3-b9HW6k2XAJeZGWBS5jRe+WU0pCJJFmQ@mail.gmail.com>
Subject: Is /dev/ttyACM0 of ATMEL serial CAN bus ?
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi All,

I decided to split my correspondence with Oliver to be very specific
I have Atmel Chip  on DELL 3201 board with built-in CAN port , as well
as LAN and  USB ports

I followed Dell manual and run proposed command below

> for i in /dev/ttyACM*; do udevadm info $i | grep -q 03eb_2404_USB_CAN_FD && echo "path:/dev/$(basename $i)"; done

It prints the device
 /dev/ttyACM0

What is this device?
Does it serve CAN port or USB port?
Can I use it as a serial CAN  device?

BTH, even kernel 5.3 does not have a configuration option for ATMEL CAN device.


Thanks all
Lev
