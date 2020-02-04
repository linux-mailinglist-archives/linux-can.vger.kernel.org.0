Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03E68151AEF
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2020 14:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgBDNHt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Feb 2020 08:07:49 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:38169 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBDNHs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Feb 2020 08:07:48 -0500
Received: by mail-il1-f179.google.com with SMTP id f5so15787813ilq.5
        for <linux-can@vger.kernel.org>; Tue, 04 Feb 2020 05:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=B/x4R2YjWm8e4cIWY2ISXYlFX6nVenfC/Dz7ahvAC8g=;
        b=RW6dTvOh6K4eJy4e21R91q3lP4rWwYlWFrvsrae1jGZ/JIUz1+cJ7VKmTojyEeV22J
         Nu48M/cvzjcL8IKTNs3w7XoiXipnloVOk0QYNSnlGeUV1+V+VV85ncPx3C9b9U3K0+fT
         8Rtd4KhvPaZJsYDv40wz8bDqTfxv/sOewm2sFsaOIEZk4oAcM5TlDnlKrTX85eCCV8+9
         t3GQSYpv9F2Sd+v83g9kJpfpRcdNbrkoarVYIU5G37eHERPbU+p4iUwHm+OiekDagl4l
         bvN32l8yB+SrNWS8G1ZNZQjUGn6FSB4Ljwpkzc5W5nJadeMxBqbT5YlPlznrvZgFZnSg
         HYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=B/x4R2YjWm8e4cIWY2ISXYlFX6nVenfC/Dz7ahvAC8g=;
        b=JMPBe83JTZefMpkjzHzfEo6mC2mE+h2vWAvamPe60Sk1M+Y+cfPaPUY1CcbBI9ZAGL
         9gYWdqzVnu2c2Llh0wY/JdNtBle+u71rSCE8q3wqWBne0YM7Afqi5wy7zRtAfbZsSL27
         mQhlyr2Lk5nJFvK3z4wBcRFmNQ6XnxcgJqOxOeL62mw8BOYbsYu18qCLUcYKGAFpqM+S
         mDq33z4bLtZ2SND8xpITCxK/KImNxmRKUr3/CRX1ohD5ChmDTNyf9ouVkx+AAEg95gOW
         zB5491jPZc7cWHR0UYqVL7sChB0R8jzmaCjvOKHfo1GNMSwmv3rDtjfb7/EWNaUzVNl/
         zxkg==
X-Gm-Message-State: APjAAAX55N+n/yzbJCASXeQ1f+M7/Rxdne9RUFbRdAL53Q9tLlOCs4fF
        ohowOT7bueY9IKH6P8aZZAmYmtRWmMw8pcmfzA2khsJM4hk=
X-Google-Smtp-Source: APXvYqzZKmB1TfyE8/gZ0bKxj1DaSOeKDnD/77t9d0Hhagwv98xFK1EbJodn4EYvrhvrkfpxv4dG1RzCcPcQh5P6vBI=
X-Received: by 2002:a92:d642:: with SMTP id x2mr20547656ilp.169.1580821668011;
 Tue, 04 Feb 2020 05:07:48 -0800 (PST)
MIME-Version: 1.0
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Tue, 4 Feb 2020 15:07:37 +0200
Message-ID: <CAP22eLHKe=0FEoS3DfRK8Oi6k2xntCvxQPVpXhau_bnuOAs71A@mail.gmail.com>
Subject: Help to set up can net interface on Dell 3200 Intel Atom
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi All,

I have with DELL 3002 Edge server
It has can and can_raw drivers loaded at boot time
It does not have /boot/config.txt file

Unfortunately, I do not have kernel sources and kernel config file is
not present in /proc, so I do not know which exactly chip is on b
oard and board specs says only:

(CAN2.0 A/B/FD) 1Mbps (CAN2.0), 5Mbps (CAN-FD).


I tried to set it up but get the following error


root@5HCF902:~# ip link add dev can0 type can
RTNETLINK answers: Operation not supported


Thanks in advance.
