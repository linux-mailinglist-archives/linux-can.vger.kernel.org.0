Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5C212A6CE
	for <lists+linux-can@lfdr.de>; Wed, 25 Dec 2019 09:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfLYIdT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Dec 2019 03:33:19 -0500
Received: from mail02.vodafone.es ([217.130.24.81]:27665 "EHLO
        mail02.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfLYIdT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Dec 2019 03:33:19 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 03:33:19 EST
IronPort-SDR: A1JscnNi6KNTDVdYnAJLy4gtBf/tw3gZdKZx/tuIxOr5RIWQxLo/tGbgQjKY8LcAUeKqrQeJ/n
 dTrEBRYCZEYA==
IronPort-PHdr: =?us-ascii?q?9a23=3AwDJtVBSA9Px5ggBsVATlfE97Idpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6yZByN2/xhgRfzUJnB7Loc0qyK6vumAzZbqsnb+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLqMUan4VvJqkzxx?=
 =?us-ascii?q?fXv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/WfKgcJyka1bugqsqRJ/zY7Ofo+bN+dwcazBct0VXm?=
 =?us-ascii?q?dBQsRcWDBdDo+gc4cDEewMNvtYoYnnoFsOqAOzCw+2C+jy0DFInH723ag70+?=
 =?us-ascii?q?Q9EAHGwhYvFM8JvXTIsdX1MLsdUeGow6bS1jXOdPZW1i386IjMaBwhve+DXb?=
 =?us-ascii?q?ZufsrJ00YgCxnJjk2MqYH8OT6ey+cDs3CD4uZ+SO6iiXQrpxx/rzSz3MsglI?=
 =?us-ascii?q?bEipgbx13E8yhy3Zw7KseiSEFhZN6pCJ5QtyaHOIRoWs4iWGRouDoiyr0BpJ?=
 =?us-ascii?q?67YDAGyJQ5yB7bbPyKa42I7QjiVOaVOzd3mnZldK6wihqo70igzfDzWdO60F?=
 =?us-ascii?q?ZNqCpKjMPAuW4W1xDL68iHTOVy/lu51DqRygze6PtILV06mKbHMZIt3LE9mo?=
 =?us-ascii?q?AdvEnDBiP2nV/5jK6SdkUq4Oio7OHnb636pp+BM497lgD+Pbk0lcykGuk4Nx?=
 =?us-ascii?q?IBX2mf+eimyL3s40n5T6tSjvIsjqbVqojaJdgDqq6jHwBVypoj6wq4Dzq+1N?=
 =?us-ascii?q?QYnH8HLE9KeR6ek4fmIVfOLevmDfewnVusii1nx/PYMb37BJXCMHzDnK3mfb?=
 =?us-ascii?q?Zn5E4PgDY0mNRe4Y9ET7oIJtrtVULr8t/VFBk0N0qz2em0Mthl0pIiXjerC+?=
 =?us-ascii?q?ehKqLXsEOJ+Otnd+2FfJUUvTfhKuYs6uXGn3g5nloUfK3v0IZBO16iGfEzB0?=
 =?us-ascii?q?zRWWDth9YdEHkD9l4iUejhiVGLShZWbne2Gb4x4jwjAYngFZuVFdPlu6CIwC?=
 =?us-ascii?q?ruRs4eXWtBEF3ZSXo=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GTKgBOHQNemCMYgtllgkQBGAEBgns?=
 =?us-ascii?q?3GyASk0JUBnUdihKFM4N8FYYaDIFbDQEBAQEBNQIBAYRAgiIkOBMCAw0BAQU?=
 =?us-ascii?q?BAQEBAQUEAQECEAEBAQEBCAsLBimFSkIBDAGBayKEF4EDgSyDA4JTKa0XGgK?=
 =?us-ascii?q?FI4R1gTYBjBgaeYEHgUSCMoUCARIBbIUhBI1FIYhLYZd+gj4EljANgikBjDg?=
 =?us-ascii?q?DglSJEacigjdVgQuBCnFNOIFyGYEdTxgNjSyOLUCBFhACT4VAh1yCMgEB?=
X-IPAS-Result: =?us-ascii?q?A2GTKgBOHQNemCMYgtllgkQBGAEBgns3GyASk0JUBnUdi?=
 =?us-ascii?q?hKFM4N8FYYaDIFbDQEBAQEBNQIBAYRAgiIkOBMCAw0BAQUBAQEBAQUEAQECE?=
 =?us-ascii?q?AEBAQEBCAsLBimFSkIBDAGBayKEF4EDgSyDA4JTKa0XGgKFI4R1gTYBjBgae?=
 =?us-ascii?q?YEHgUSCMoUCARIBbIUhBI1FIYhLYZd+gj4EljANgikBjDgDglSJEacigjdVg?=
 =?us-ascii?q?QuBCnFNOIFyGYEdTxgNjSyOLUCBFhACT4VAh1yCMgEB?=
X-IronPort-AV: E=Sophos;i="5.69,353,1571695200"; 
   d="scan'208";a="317906393"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 25 Dec 2019 09:27:59 +0100
Received: (qmail 32524 invoked from network); 25 Dec 2019 04:33:55 -0000
Received: from unknown (HELO 192.168.1.88) (seigo@[217.217.179.17])
          (envelope-sender <tulcidas@mail.telepac.pt>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-can@vger.kernel.org>; 25 Dec 2019 04:33:55 -0000
Date:   Wed, 25 Dec 2019 05:33:41 +0100 (CET)
From:   La Primitiva <tulcidas@mail.telepac.pt>
Reply-To: La Primitiva <laprimitivaes@zohomail.eu>
To:     linux-can@vger.kernel.org
Message-ID: <8628406.259459.1577248427443.JavaMail.javamailuser@localhost>
Subject: Take home 750,000 Euros this end of year
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Attn: Email User,

You have won, you are to reply back with your name and phone number for
claim.

La Primitiva




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

