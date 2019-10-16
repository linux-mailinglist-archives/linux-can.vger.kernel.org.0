Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9FB9D99AE
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2019 21:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388795AbfJPTGd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Oct 2019 15:06:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43728 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfJPTGd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Oct 2019 15:06:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id u3so18379580lfl.10
        for <linux-can@vger.kernel.org>; Wed, 16 Oct 2019 12:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ReG0uHcLcivk3u6X7XJ4OEAQgvHGLO5/BgkUYtYawuU=;
        b=j13n/kAlUIwSkqTkgOHq3rDu/+oVbJeoGtMp3tInpKdfTNCox0/pZgg4lDnbc7qjeJ
         QR+ddxaU8xw6XkP/MFUwj88L/McJDbB8bD4Nhsn6jJq5vKniZ2PO/TS3AJ60WSn1qCRN
         MaoB0hXTUVDiaSr8/HJvHt4PDtYduDWccYiK4OmQCzpVe6tmAi7h1wTUoSaxnnApd1Kc
         27x7BbsWa5Zoia0sKDTubszGjRi0GysCn6poPPog8E89zHrhlJ1D8pAPGdcnQ997uFQH
         RCrPG8DgxIJKVRgeTJMkKsQUVC8WY+9trIcqC7zVbqfb+L9qA1BxUGOB0QKt5hkBCYxO
         er9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ReG0uHcLcivk3u6X7XJ4OEAQgvHGLO5/BgkUYtYawuU=;
        b=PE1IGHQcAGXYTcCIb6E4S3DogpTWwX5gWnEdo6EbD4R+VH0pc/lHzlAgXXRnAA6+r9
         4QkdMT3RPm/eiM9Ak0C6vy4ZjrMIehqGxUTfJkcRk2QmfjvFTGGj8CxguMkOXE2r1xyF
         a3acD+rqOeEK8l5oltu/ToJZNnlkj2bO5kXzVlGguManhK2oZooA611GNwVYbvPR3uTn
         73J84bT1GAz6Gtq1hlz8+iVOpNMmV5iGj9joVpw6EZCAHocQb4KL1uOvYQAt5hDkW58C
         thuz1eAeJnVtPkcFkXtRKak1IpS53ZLdBwJzRhD531IQco/Nw/e/ezLJrqtavtrk9r0J
         lwxg==
X-Gm-Message-State: APjAAAWTTRB21qIL7Bm0K3KnjklKnhEq7C1RUZ97X9JJXBS/0lwgjWO8
        TP5qap5lnAuDVs1pSVxCqtWR+tsTdKZ9BkXUJAS6nA==
X-Google-Smtp-Source: APXvYqxq4FG5cnFOjMR1coBCZHgjYCwWF35jYTXgaDn/OWhjafh4UHGbP7aJXB5ReLJyQ7iuOLC75KF7d7IaHw563ek=
X-Received: by 2002:a19:8c5a:: with SMTP id i26mr26027115lfj.118.1571252790595;
 Wed, 16 Oct 2019 12:06:30 -0700 (PDT)
MIME-Version: 1.0
From:   Elenita Hinds <ecathinds@gmail.com>
Date:   Wed, 16 Oct 2019 14:06:19 -0500
Message-ID: <CAHChkrv6cKgNam-znKu_wOZm-y6gNkONmGWP6RFZpiSprq5_gQ@mail.gmail.com>
Subject: c_can/d_can driver question
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

I'm hoping someone can help me with this ...

The DCAN module I'm testing with supports 64 CAN messages and DMA. The
combined c_can/d_can driver seem to only support 16 RX message objects
and no DMA (as far as I can tell). I noticed that older Linux version
(3.1) implemented a separate d_can driver that supports both.  I'm
wondering why these were removed from the latest c_can/d_can files.

The reason for this question is I'm seeing frame losses and I think it
is due to the driver. Increasing the socket buffer sizes did not have
any effect; the number is overruns was still pretty large.

Any feedback would be appreciated.

Thanks,
Elenita
