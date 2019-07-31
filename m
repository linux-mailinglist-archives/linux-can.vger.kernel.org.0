Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 515827B7C2
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2019 03:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfGaBtx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 Jul 2019 21:49:53 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:43183 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaBtw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 30 Jul 2019 21:49:52 -0400
Received: by mail-lf1-f53.google.com with SMTP id c19so46172964lfm.10
        for <linux-can@vger.kernel.org>; Tue, 30 Jul 2019 18:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=capp-tech-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=QuJOoQOVh8pTO2T9T3FOD/YK1UkPfo8R/S4Of+METNI=;
        b=h2pSpvM0urS9nZxgOaDyxuZ9g5Vovp/HgqDCrE8kJbMTBbOUn9KfrVbkZJmOkQ1C6K
         O8vvzWysoy5C+5QTVHk6eYLKCdZgn6/WwQvSnAH2krSNQci9owaHc9fM+72VV4he4fQf
         SwNr+BacKDSL5sDMJOB0JfM4HYnd67ygpa6aHSbsHgB71DBDgxeOf5ovC+7eJGTBPJf3
         VteyC0Rw+4eyEdl/0kiTCWS00Gzsw2RBIdTLFPr7I1jbmqe+gFVW5E5LCIfG72KzArgZ
         MAWY4edbjr8JEHTSclLORWYCMFRx5cqzUlvuROWw7yDjmM+HxgDOfrPMh8vLnDB+6Y+t
         hN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QuJOoQOVh8pTO2T9T3FOD/YK1UkPfo8R/S4Of+METNI=;
        b=t3iEaKlxwnxAkrv0nf2ul6fzaajIxokN4Dse17tITVAo0HScY3/xZzkGusdDVRZlZO
         0eONXLxaFM8NJnRQRKc5uCVQHt9YUVxDRUir+5HC/UWFs1XuupSe98OHOYdtn9f0Nbr1
         MvlGYo6rMaSiqfuF5Nvm4+cxsCLU9e6KWBkeUoB0p9Gl6ObA8AGiYvjQnaRKltK/yna0
         F31ANX7i+WU2AGBxQKAxPuMmpDW/0wAsq9BYRbQo4KzV0mTG45DFI9iVXio4E8oc4ZTw
         ArHTXJgBVKbYmpwNfrBzjka6SUzdbdoyW/u2M+AfnD/MzXb+Pg1HdTbauNZugUXfsaMC
         DpoQ==
X-Gm-Message-State: APjAAAU7gcOLQeBJAnsW3/Mqpo7XXRucbiQztxkQgjlfBkihnUflMYvY
        TO6paoeXH8d5SRgNbZkmZq1CiCKZeenQVoXYwhj7wtfByGI=
X-Google-Smtp-Source: APXvYqz564s+700ygz2TJ/rPjyaia1Zf4hqR8jVEK7BUiOm3mHjkkTSASrMh3a7ZY/Jv1ozADjW0VYLWRJ8DddVFVz0=
X-Received: by 2002:a19:6e4d:: with SMTP id q13mr14934655lfk.6.1564537790684;
 Tue, 30 Jul 2019 18:49:50 -0700 (PDT)
MIME-Version: 1.0
From:   Tom Prohaszka <tprohaszka@capp-tech.com>
Date:   Tue, 30 Jul 2019 21:49:40 -0400
Message-ID: <CANRGksgbzcwt+XYNbZNrRMy=MXrT4WjXXW814=xYUgiJG+9twA@mail.gmail.com>
Subject: Disable Network Statistics - CAN
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

We are using the MCP25xxfd driver.  A comment in the code indicated
that during testing, the network statistics were disabled to achieve
high utilization of the CAN bus.  Another comment indicated that when
network statistics were re-enabled, a 60% decrease in throughput
occurred.

My question is, how can we disable the network statistics for CAN, and
if not possible for CAN, globally.

Tom
