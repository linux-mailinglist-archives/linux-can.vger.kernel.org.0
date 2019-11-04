Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3BD1EEB1F
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2019 22:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfKDVaB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Nov 2019 16:30:01 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:42612 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDVaB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Nov 2019 16:30:01 -0500
Received: by mail-io1-f43.google.com with SMTP id k1so20193322iom.9
        for <linux-can@vger.kernel.org>; Mon, 04 Nov 2019 13:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suburbanembedded.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T7J8l9kJli26jcT8bRhc2urjRFD0guvHvkpEnQvkvwk=;
        b=CedsL8k1Wrs/r53Fi0fRJzANUC/l/ImVQdiGQ6EnNXU7VmBRgkGeaFEb3/rXpQ2Nal
         O575E4pK3f3hcjM8+poU7Pji2ZJgIcjeRYRcX598d1LUDwHa6ny6BT4UGLGLkmZnpvqc
         6cCw65KONIWZo/fYiEv4FUf3XWBRDxUh31T1bK8pCtV/bEk5pWTJ1dBfwx2tA7g+yigX
         JFVWHkaO0fR+Nob0vHUTl/Hp0yYmL9pGynzSQ6LbXmH9Ic/0VOGQLyH8QZ+A43lAScjA
         oFK57WlaCENId6iQW6JHhrbkzlIXSAMCMLgTK+T35na8b50EL7vPSNvbxjaFW85YBrci
         3XZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7J8l9kJli26jcT8bRhc2urjRFD0guvHvkpEnQvkvwk=;
        b=by+e9v30IIW/ZXd/y/qLTcNN02bPwloJYuV4VISBSmdriPUVGQeeliLI5+V6MnemyC
         24pht6Qr5fUJye494bjqQyv1W25I1wU2VZWD8/XDqscbbCl9d60tn25B8Shi36H1+24y
         hElDoyr7HifGf0PuJrU2KXYPnB3Q7CUMI3mQSy1pgi2UujDU2z0hfP5XmuvGtUTRoUTU
         drGM7lgAtdQFYFoXk58us2ss6PPw4qCPQ0p1GLnq0SrnWJsYadQ9vBi44s/1IIw69WOE
         e8jouozymvKAVHBVVRoxFi2MAu1J8OD0Juec7l8nSI43oxjC6x6mRADHqNSfQFhJsNFK
         FGlQ==
X-Gm-Message-State: APjAAAVnabRsNAF9RGjUrjlvNv7LL3u/hQpNmVayh+YetEhC60YT6Jy9
        JWeEQRAp8FASjJQjqJwrr85mg5FJj0DXppAw1bvccA==
X-Google-Smtp-Source: APXvYqy0ik0TpSQfQwCughJx+SIAl0UMTXTXoIw+m7NojlJlrFc7qgjHP+gS5DAjKzBCbxgf/kUvxq/Y/sstdebFbUc=
X-Received: by 2002:a02:58c8:: with SMTP id f191mr2532218jab.94.1572902999966;
 Mon, 04 Nov 2019 13:29:59 -0800 (PST)
MIME-Version: 1.0
References: <CACj_+4Y8904tbswy76Fpp6wGKZPdNpSrfDq6BvfTAGzs4zHT8w@mail.gmail.com>
 <97900bc5-48cc-b167-203d-ec7735009009@victronenergy.com> <CACj_+4aLfS9frR-sVkr1YcpYk+3pMZ85ALOrMWN2k=pVwJDLJw@mail.gmail.com>
 <3839c2b0-e6d3-98db-f774-6165f0c1cdcc@victronenergy.com> <5d51f507-d52d-2711-ef8e-180402f3dade@pobox.com>
In-Reply-To: <5d51f507-d52d-2711-ef8e-180402f3dade@pobox.com>
From:   Jacob Schloss <jacob.schloss@suburbanembedded.com>
Date:   Mon, 4 Nov 2019 13:29:49 -0800
Message-ID: <CACj_+4ZmGEphoH0iu8jyemO3y25S7WtqgPLH1h6oFj46KegRog@mail.gmail.com>
Subject: Re: CAN FD support in slcan - protocol extension?
To:     Daniel Santos <daniel.santos@pobox.com>
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> I have been forced to modify the USB protocol because I need get 2Mbps
> of CAN to work on FS USB and the current protocol won't get there.  I
> cobbled together a crude bit-packed mechanism, but I had forgotten about
> the FD CAN 64-byte payload scenario!  Since this is still in flux it
> would be a perfect time to design a better protocol.  I haven't used
> slcan and I don't know about it's protocol, other than it would have to
> be ascii-based.
>
> Given all of this, I *think* I'll design the USB protocol to always
> re-submit dropped bulk IN URBs and drop any CAN/FD frames that are
> received in excess of the device's internal buffer.  I *think* I would
> rather do that than design a re-sync mechanism for when a bulk IN URB is
> dropped (i.e., instead of dropping the frames in that failed URB).
>
> I'm working by the general assumption that the device is attached to a
> hub that is HS and that the bottleneck will be between the device and
> the first hub.
>
> Daniel
>

Hi Daniel,

Sounds interesting, I'll take a look at the repo, and will look at
what it would take for my firmware to be multi-protocol. I suppose
stream sync loss will be rare, and could do a USB reset as a worst
case recovery. This is my first USB device, so haven't done much error
/ stream sync recovery on USB yet, just UART where I needed explicit
synchronization. I need to do some more hardening on my device side.
It would be difficult for my code as-is to resync on a failed USB
packet since the payload is just dumped in a FIFO that the app is
waiting on and the application part doesn't even really know it is USB
or where the packet boundaries are. Probably just need to add some
event hooks for errors the app can use.

- Jacob
