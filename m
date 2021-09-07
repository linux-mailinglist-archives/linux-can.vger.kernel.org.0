Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270D6402B48
	for <lists+linux-can@lfdr.de>; Tue,  7 Sep 2021 17:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhIGPDL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Sep 2021 11:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231362AbhIGPDL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Sep 2021 11:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631026924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=rbPd82OCJenSUwgqcS1/q+JFqKruJWRVvphp1xBN6U0=;
        b=XcRAZvdH6AdmNlZH+rtO74m3zxbXjbTv5wDO+vJQQ5m3YPFFoz47YatygFpHId8nb68IzV
        xCq9NYflj/yRxAVSNgnaeyassoWHABFSj5WHGNn1IgLE7dNlTaRLpWKZi+roT/Ov65tSVe
        98umrsclzkDv6AVCmTev1GprFOfx490=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-g6luDNbGMHiuf54gFt8Sdg-1; Tue, 07 Sep 2021 11:02:03 -0400
X-MC-Unique: g6luDNbGMHiuf54gFt8Sdg-1
Received: by mail-oo1-f69.google.com with SMTP id w9-20020a4aca09000000b0028b7adc5bd2so5870822ooq.11
        for <linux-can@vger.kernel.org>; Tue, 07 Sep 2021 08:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rbPd82OCJenSUwgqcS1/q+JFqKruJWRVvphp1xBN6U0=;
        b=jBdOf2SoRE62lp4q+zI8ZAQOD3aaRHaVu2C8be2b9DMr8g6xo50wWxW/4y2HI3KZol
         p20CnG9NpN1len0fBem59a3mv0YqG5yRE9kVvMgOUmIScZmG+nH8gTKOxZWYLY2kJb7M
         F9yhsegOJRYycjcAFjUcrqa7IofHq2wIWf3ZGPxTtM7WCmowIkCvVmHNgcODaD/DGjDz
         AUQqdio15oRriluKVWc3FYyXoKbXBRb8Nz3iB11bQd00XwmjH4ctzyJRR8qFpGDEQA6r
         8LcKiyzUDQHITkR0IBReLKTaGtDJrqZkN0kVE7jrtsBV+8coGQoLFK9oFkImxD5LB0Nn
         Lc9A==
X-Gm-Message-State: AOAM533lRIKFF727UjAumyxtcFw5qZM3hoWKOz8wo7MKnK4vA6aPSnhS
        zrtRCYPW2xoxC3rjG/P0Zmrls7J+/+3E863gC3ohm9TFohhI78PndDX9d6AQP+L0ZHfcU3qQ7z1
        llgzTb6yE0Ws7LdpEnH77FoXqbWyuN2rLVsuD
X-Received: by 2002:aca:b2c1:: with SMTP id b184mr3328383oif.70.1631026922096;
        Tue, 07 Sep 2021 08:02:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR/Ygkn3XlFQ47FTsaxmmo/szWWZUbjdmjoE/Z3w3qoFdDnekFV+dvRyGhJkPXtNZTblFxaiwIkdnkiSrMkBM=
X-Received: by 2002:aca:b2c1:: with SMTP id b184mr3328368oif.70.1631026921844;
 Tue, 07 Sep 2021 08:02:01 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Tue, 7 Sep 2021 16:01:51 +0100
Message-ID: <CAOgh=Fz5Gs6+ouPpFs4TeQW7rL-nEU-rqsj4w99TtQw2Pikr4w@mail.gmail.com>
Subject: Introducing packet problems to vcan interface
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Guys,

I'm new to CAN in general, I was running the following commands
to set up a CAN interface and send it some data to see how it
handles undesirable scenarios.

sudo modprobe vcan
sudo ip link add dev vcan0 type vcan
sudo ip link set up vcan0
sudo tc qdisc add dev vcan0 root netem loss 10%
sudo tc qdisc add dev vcan0 root netem duplicate 10%
sudo tc qdisc add dev vcan0 root netem corrupt 10%
sudo tc qdisc add dev vcan0 root netem loss 10%

followed by:

./j1939cat -i ../4M.bin vcan0:0x80 :0x90,0x12300

But the packet problems introduced by TC, seem to have no effect
on the cat time. Does TC work with CAN, the timing to transmit the
data is the same with TC introducing problems. Should I be
expecting retransmissions etc. to occur?

