Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543F31B8FBA
	for <lists+linux-can@lfdr.de>; Sun, 26 Apr 2020 14:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgDZMHY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Apr 2020 08:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDZMHX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Apr 2020 08:07:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8F2C061A0E
        for <linux-can@vger.kernel.org>; Sun, 26 Apr 2020 05:07:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d17so17116870wrg.11
        for <linux-can@vger.kernel.org>; Sun, 26 Apr 2020 05:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QZnMqhr0+003fhPEhEKJLeyqcg4vQo5xSehdtWaikis=;
        b=Pr2JBeTRrK6Ic1mB28tSNY00Twh0JkUTFb4jFUc2e+9q/S6KZdFcad43fs1WogDyxi
         xEppWM85oc5CUJ1z5gC5xKfilYjn5MHVUwK2Al5NZ7b4YNEMKOBkU5updSkvGKv4BpDo
         V98/vMI14FTkD7gbHI9D9jby3rlFrSmYIuaLusVftt/kZ2sNH4bQi8M3KbrN1at5n0wW
         KaYc3l8n5n7Xgbc6GWurMLrV9Vu9uqeZhDReulpt5458/uDlM0R2hjXnvmF1jepPlVYl
         ASsTKkHxyQHd4pJCND1TZuKHpLivS7KaMOlHU3n7hUI10SU9o+7oIKPo/nzY9PFuWmB3
         ln2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QZnMqhr0+003fhPEhEKJLeyqcg4vQo5xSehdtWaikis=;
        b=ZlspXgIei3MFNXGmP1TyJVK1rx6S800FlX+BkemFdtGUsGcb3stREF/byx+KbXtJ53
         EH71Ty3P4dPyz7G4W7hT6cGOsfNiYbMlOA7V7eND4+uj7UjLpY6OB1CWHsc/vMnP1vzV
         hWcD631EddJfdmWGCjr0ghvLyLiiw5pM/WGxdx3oedUD/MQORGIOymo7R/5dZx26HY4z
         9pgCRLgC1wgsJy3wV8KyLQ8zmXUPRmz8I5lR+08oU5kLzBGyAJDNX+1M6G46PfOkPnFa
         OXeBskBczinHTRNZGTZY5gN5HxMavXB+6DOO6yaqWOmjQpzIwxCqaNl8O7Jy6OGumgkA
         +0hQ==
X-Gm-Message-State: AGi0PuaB1HMVX4S0A11ztSjgcjIUFtYDRKY02Rqks37u6z3yj4igFV/i
        jCppjTjaXy3FLYoBpauNhSHLXVcLsQf8IrHzepkW6f3o
X-Google-Smtp-Source: APiQypK3kmqVnOzy4JZP1ImW0r66B2CqWtdD6W5hxRuTIedsRmG3HjO2dajnpFZQZIIEYPCRu2Qh5AfUv5wZqkrcl/o=
X-Received: by 2002:a5d:4ac9:: with SMTP id y9mr23208085wrs.182.1587902839448;
 Sun, 26 Apr 2020 05:07:19 -0700 (PDT)
MIME-Version: 1.0
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Sun, 26 Apr 2020 15:07:08 +0300
Message-ID: <CAP22eLGTc6K1auF5JOofTKy83uTOq0hK_qb8fgJ=J78njwWjVA@mail.gmail.com>
Subject: Are there any netfilter modules for use with Socket CAN
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi list,
From my google search I did not find any netfilter /iptable rule which
allows to filter on CAN fields,  message ID and other.
Please point me in the right direction.

Regards,
Lev
