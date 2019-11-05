Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB84F02A7
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2019 17:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390194AbfKEQ1D (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Nov 2019 11:27:03 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:42285 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390060AbfKEQ1D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Nov 2019 11:27:03 -0500
Received: by mail-io1-f70.google.com with SMTP id w1so15939207ioj.9
        for <linux-can@vger.kernel.org>; Tue, 05 Nov 2019 08:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xk1NyHbooEy4YsKg2M7xCtDevKehR0j6/pRBBy2vjNw=;
        b=g8zNG1vX+C0sWqhytRfFp3TrSpQNmZq1SvivHZgztKNUdIjanLAYdBQCGuiZy5XBWR
         F6Ug1XT25SLU3/t1dPYCKYGP6YpKwXZ4ae8HRzcquQZQHqV4yubyWsO9FdtsSUb0BZ9F
         ucSK+KeHXsZvhqZ6KYNFtWE/LScicjKDoNCYYF3mjbU0SCMuq+Y56VCFBcVSGQEbSki8
         wivMLTkGD7g0HRBg/FrlRTkePMZh9SQVnoewVFjZ9TIxoyTpRq8seHa0YjDBCGVNN7jY
         Vi6fssvivwR3FPljqR0xXYnE51q72OiwBwW/PtIvfgtcth67e/iKD4S4UZSLWbkCxObM
         hSQQ==
X-Gm-Message-State: APjAAAVt8iCGaqkmpm3gW5qGwumfDE9PfUkbTv9PTtS/biK73lRHAZd1
        T/18Ujo7RdFPXNfAnX94EI9UdbxHPSDldlRFzBIKRAPXMW30
X-Google-Smtp-Source: APXvYqw3IqVWZQAVPDbpkfRF7hE8RcQNgey/R6Pf8G7Cgo3IYNCKrAbGg2rE8MnLaYC40eT3Z15gtUy8nMeNqMMOMFCOhtwdKjkd
MIME-Version: 1.0
X-Received: by 2002:a5d:9954:: with SMTP id v20mr4300127ios.188.1572971221308;
 Tue, 05 Nov 2019 08:27:01 -0800 (PST)
Date:   Tue, 05 Nov 2019 08:27:01 -0800
In-Reply-To: <000000000000a367e3059691c6b4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e36a0405969be68c@google.com>
Subject: Re: general protection fault in j1939_sk_bind
From:   syzbot <syzbot+4857323ec1bb236f6a45@syzkaller.appspotmail.com>
To:     bst@pengutronix.de, davem@davemloft.net,
        dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de,
        netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

syzbot has bisected this bug to:

commit 9d71dd0c70099914fcd063135da3c580865e924c
Author: The j1939 authors <linux-can@vger.kernel.org>
Date:   Mon Oct 8 09:48:36 2018 +0000

     can: add support of SAE J1939 protocol

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16267168e00000
start commit:   a99d8080 Linux 5.4-rc6
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15267168e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11267168e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=896c87b73c6fcda6
dashboard link: https://syzkaller.appspot.com/bug?extid=4857323ec1bb236f6a45
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110a8b8ae00000

Reported-by: syzbot+4857323ec1bb236f6a45@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
