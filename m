Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F251F161C70
	for <lists+linux-can@lfdr.de>; Mon, 17 Feb 2020 21:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgBQUtd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Feb 2020 15:49:33 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:36414 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgBQUtc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Feb 2020 15:49:32 -0500
Received: by mail-lj1-f178.google.com with SMTP id r19so20363312ljg.3
        for <linux-can@vger.kernel.org>; Mon, 17 Feb 2020 12:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AhIb+PRqxJBDadI+d40gQyaLj/ZCjL6ux0hC6u7Gwog=;
        b=Owxs6GS22nWiTkr/gyZkMIfrWshavT2VrRrnnVFbsd840HGhfsFy4orGMy6kWS44Ct
         azPzT201nUXFgBLDhA2f7SRJXstUynaPfvZ6k7e+8J5fL0urd471IoCFEajvHWaSjVZk
         mmPrNZTXCZ9kFe05J3p9oMTiO/UvS2uay5R2IbbylY/wHTs4jWdp+yPCW0OFCL4/NKNU
         iKBBd06ydkqUU8wG/y0545AZc7uqniCh9pQcSwv1Z6VrcbnfL4Oc3t+fqbiMHH/08DP9
         Qb5tsceHO4pSVL75shEq/dmW/36ZcUfxAX6Ngq91FkApRy+DGWUDULpYd4nDQgVMZYJJ
         hQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AhIb+PRqxJBDadI+d40gQyaLj/ZCjL6ux0hC6u7Gwog=;
        b=BxC2NRo/HquU9XteIQKnJu+muy2WIf/ejF0Wo9rD8dqwo3Bfs2n/8+WbJh0xn/g0zi
         cQviT7JXvaqWYuuLtGhREBH1KULGfBsUsjBJnkqVKeutfF+h3qnVDgv+8Pr1FoYsgLeV
         7L6ilUul1BLWo6MkxgcoLdo3VWfmTXglB+F9rVjn7Dcc64blDfNueUno6W4GSdqIVod6
         yaEgFHPcQlUrBerCh7MuJC3fSYYpCWurz4+3vlIWtWMi7KjY+9CxMz26S++pwLw4C1PW
         zxyyZeLlywPA2TYGU+UIeck+IvfDGhngr8Kidf7BNk7DpiTue4HerrVN7RqInelsd/mw
         7Ytg==
X-Gm-Message-State: APjAAAUghE8AeR2q3dm73RsYj43wAtkN7IysvJQT1eS7/J/kefgCtZrv
        owQm0WxLlxybkh7gLsipHEAJuQZXYBeUTK3MCIq1gZhx
X-Google-Smtp-Source: APXvYqzgPnImCCWWMEMyHpIsik/uc+m69HSENZ0wF+t5qQOVt4HsbzjLcTA74sAhaGzemoqnHAKcZnTfW906QS3Junw=
X-Received: by 2002:a2e:b6ce:: with SMTP id m14mr10194617ljo.99.1581972570116;
 Mon, 17 Feb 2020 12:49:30 -0800 (PST)
MIME-Version: 1.0
From:   Elenita Hinds <ecathinds@gmail.com>
Date:   Mon, 17 Feb 2020 14:49:18 -0600
Message-ID: <CAHChkrtxFyzZz2yTAOvui=-j5QA3=2_Qoe6whWe+TDzZJk4QVA@mail.gmail.com>
Subject: J1939: Unable to receive and transmit multi-frame messages
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

Back when I was using just the J1939 branch (before it got re-written
and mainlined), I was able to receive and transmit multi-frame
messages.  Upgrading to kernel v5.4, this is no longer the case.

For the receive part, it is failing in j1939_tp_im_involved_anydir()
call, which is the first thing called by j1939_tp_recv(). The socket
is set to promiscuous mode; has no problem receiving ALL the  8-byte
long messages but fails on longer ones. There should not be any
difference with how the socket is setup as far as the message length
goes  but is there a new step needed in order to receive the
multi-frame messages as well?

The  same question applies for the transmit side.

Thanks for the help!

--elenita
